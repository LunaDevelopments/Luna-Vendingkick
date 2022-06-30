local QBCore = exports['qb-core']:GetCoreObject()

local vendingItems = {
    [1] = {name = 'twerks_candy', count = math.random(1, 3), chance = 99, robbed = false}, --100% chance
    [2] = {name = 'snikkel_candy', count = math.random(2, 6), chance = 50, robbed = false}, --50% chance
}

RegisterNetEvent('luna:client:vendingkick', function(item, count, chance)
    TriggerEvent('animations:client:EmoteCommandStart', {"karate"})
    QBCore.Functions.Progressbar('add_water', 'Kicking vending machine...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, { }, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Wait(500)
        if time == 0 then
            for i = 1, #vendingItems, 1 do
                Wait(500)
                local chance = math.random(1, 100)
                local vendingreward = vendingItems[i].name
                local count = vendingItems[i].count
                if chance >= vendingItems[i].chance then 
                    QBCore.Functions.Notify("You found nothing", "error")
                else
                    TriggerServerEvent("QBCore:Server:AddItem", vendingreward, count)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[vendingreward], "add", count)
                end   
            end
            time = 240
            timeouts()
        else
            QBCore.Functions.Notify("This machine looks empty", "error")
        end
    end)
end)