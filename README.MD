![newBanner](https://user-images.githubusercontent.com/52039113/176376396-08f0e002-2eaa-463b-af11-e2a367496372.jpg)

Want to join LunaDevelopments?
https://discord.gg/RrxjE4dEbp

luna-vendingkick

please edit this to your liking.

Vending machine kick script. 

You can change the loot and the chance of getting loot.

This script also has a cooldown so people can't just go around constantly kicking vending machines.

Put this code inside qb-target init.lua under the section Config.TargetModels
["vendingKick"] = {
        models = {
	    `prop_vend_fridge01`,
        `prop_vend_snak_01`,
        `prop_vend_snak_01_tu`,
        `prop_vend_soda_01`,
        `prop_vend_soda_02`,
        },
        options = {
            {
                type = "client",
                event = "luna:client:vendingkick",
                icon = "fas fa-shoe-prints",
                label = "Kick this shit!",
            },
        },
        distance = 3.0
    },

