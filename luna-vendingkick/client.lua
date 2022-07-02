local QBCore = exports['qb-core']:GetCoreObject()

local vendingItems = {
    [1] = {name = 'twerks_candy', count = math.random(1, 3), chance = 99, robbed = false}, --100% chance
    [2] = {name = 'snikkel_candy', count = math.random(2, 6), chance = 50, robbed = false}, --50% chance
}

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
            for i = 1, #vendingItems, 1 do
                Wait(500)
                local chance = math.random(1, 100) -- Chance %
                local vendingreward = vendingItems[i].name -- pulling the items from the vendingItems table
                local count = vendingItems[i].count
                if chance >= vendingItems[i].chance then 
                    QBCore.Functions.Notify("You found nothing", "error")
                else
                    TriggerServerEvent("QBCore:Server:AddItem", vendingreward, count)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[vendingreward], "add", count)
                end   
            end
            time = 240 -- cooldown time to be able to kick another vending machine.
            timeouts()
        else
            QBCore.Functions.Notify("This machine looks empty", "error")
        end
    end)
end)