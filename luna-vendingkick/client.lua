local QBCore = exports['qb-core']:GetCoreObject()
local time = 0
local Config = {}

Config.vendingMachines = {
	{prop = 'prop_vend_fridge01'},
	{prop = 'prop_vend_snak_01'},
	{prop = 'prop_vend_snak_01_tu'},
	{prop = 'prop_vend_soda_01'},
	{prop = 'prop_vend_soda_02'},
}

Config.vendingItems = {
    [1] = {name = 'twerks_candy', count = math.random(1, 3), chance = 100, robbed = false}, --100% chance
    [2] = {name = 'snikkel_candy', count = math.random(2, 6), chance = 50, robbed = false}, --50% chance
}

Citizen.CreateThread(function()
    for k,v in pairs(Config.vendingMachines) do
        exports['qb-target']:AddTargetModel({GetHashKey(v.prop)}, {
            job = 'all',
            options = {
                {
                    event = "luna:client:vendingkick",
                    icon = "fas fa-shoe-prints",
                    label = "Kick!",
                }
            },
            distance = 3.0
        })
    end
end)

function timeouts()
    Citizen.CreateThread(function()
        while (time ~= 0) do
            --print(time)
            Wait( 1000 ) -- Wait a second
            time = time - 1
        end
        time = 0
    end)
end

RegisterNetEvent('luna:client:vendingkick', function(item, count, chance)
    TriggerEvent('animations:client:EmoteCommandStart', {"karate"}) -- Emote of kicking
    QBCore.Functions.Progressbar('add_water', 'Kicking vending machine...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, { }, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"}) -- cancelling the emote
        Wait(500)
        if time == 0 then
            local gotSomething = false
            for i = 1, #Config.vendingItems, 1 do
                Wait(500)
                local chance = math.random(1, 100) -- Chance %
                local vendingreward = Config.vendingItems[i].name -- pulling the items from the Config.vendingItems table
                local count = Config.vendingItems[i].count
                if chance <= Config.vendingItems[i].chance then
                    gotSomething = true
                    TriggerServerEvent("QBCore:Server:AddItem", vendingreward, count)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[vendingreward], "add", count)
                end
            end
            if not gotSomething then -- Single notification if no item was found
                QBCore.Functions.Notify("You found nothing", "error")
            end
            time = 240 -- cooldown time to be able to kick another vending machine.
            timeouts()
        else
            QBCore.Functions.Notify("This machine looks empty", "error")
        end
    end)
end)