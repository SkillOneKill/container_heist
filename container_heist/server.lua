ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent("container:serverBreakOpen")
AddEventHandler("container:serverBreakOpen", function(containerIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local hasItem = xPlayer.getInventoryItem(Config.RequiredItem)
    if hasItem.count <= 0 then
        return TriggerClientEvent("ox_lib:notify", source, {title = "Fehler", description = "Du brauchst eine Brechstange!", type = "error"})
    end

    if math.random(100) <= Config.OpenChance then
        local rewardMessage = "Du hast erhalten: "

        -- 🏆 Optimierung: Nutzt Direktzuweisung statt temp Variable
        local itemReward = Config.Rewards.items[math.random(#Config.Rewards.items)]
        local itemAmount = math.random(itemReward.amount[1], itemReward.amount[2])
        xPlayer.addInventoryItem(itemReward.name, itemAmount)
        rewardMessage = rewardMessage .. itemAmount .. "x " .. itemReward.name .. ", "

        -- Waffen-Belohnung (20% Chance)
        if math.random(100) <= 20 then
            local weaponReward = Config.Rewards.weapons[math.random(#Config.Rewards.weapons)]
            local ammoAmount = math.random(weaponReward.ammo[1], weaponReward.ammo[2])
            xPlayer.addWeapon(weaponReward.name, ammoAmount)
            rewardMessage = rewardMessage .. weaponReward.name .. " mit " .. ammoAmount .. " Schuss"
        end

        TriggerClientEvent("ox_lib:notify", source, {title = "Erfolg", description = rewardMessage, type = "success"})
    else
        TriggerClientEvent("ox_lib:notify", source, {title = "Pech gehabt!", description = "Der Container war leer!", type = "info"})
    end
end)
