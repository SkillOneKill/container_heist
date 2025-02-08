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
        local itemReward = Config.Rewards.items[math.random(#Config.Rewards.items)]
        local itemAmount = math.random(itemReward.amount[1], itemReward.amount[2])
        xPlayer.addInventoryItem(itemReward.name, itemAmount)
        rewardMessage = rewardMessage .. itemAmount .. "x " .. itemReward.name

        if math.random(100) <= Config.OpenChanceWeapon then
            local weaponReward = Config.Rewards.weapons[math.random(#Config.Rewards.weapons)]
            local weaponAmount = math.random(weaponReward.amount[1], weaponReward.amount[2])
            xPlayer.addWeapon(weaponReward.name, weaponAmount)
            rewardMessage = rewardMessage .. ", " .. weaponAmount .. "x " .. weaponReward.name
        end

        TriggerClientEvent("ox_lib:notify", source, {title = "Erfolg", description = rewardMessage, type = "success"})
    else
        TriggerClientEvent("ox_lib:notify", source, {title = "Pech gehabt!", description = "Der Container war leer!", type = "info"})
    end
end)
