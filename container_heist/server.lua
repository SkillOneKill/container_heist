ESX = exports['es_extended']:getSharedObject()

local currentVersion = "1.0.3" -- Deine aktuelle Version
local resourceName = GetCurrentResourceName() -- Holt den Namen des Skripts

-- GitHub-Infos (Ersetze mit deinen Daten)
local githubUser = "SkillOneKill"
local githubRepo = "container_heist"
local versionURL = "https://raw.githubusercontent.com/" .. githubUser .. "/" .. githubRepo .. "/main/version.txt"
local scriptURL = "https://github.com/" .. githubUser .. "/" .. githubRepo

-- Funktion zum Abrufen der neuesten Version von GitHub
PerformHttpRequest(versionURL, function(statusCode, newVersion, headers)
    if statusCode == 200 then
        newVersion = newVersion:gsub("%s+", "") -- Entfernt Leerzeichen/Zeilenumbrüche

        if newVersion == currentVersion then
            print("[^2" .. resourceName .. "^7] ✓ Resource is Up to Date - Current Version: " .. currentVersion)
        else
            print("[^3" .. resourceName .. "^7] ⚠ UPDATE AVAILABLE - New Version: " .. newVersion)
            print("[^3" .. resourceName .. "^7] 🔗 Download the latest version here: " .. scriptURL)
        end
    else
        print("[^1" .. resourceName .. "^7] ❌ ERROR - Could not check for updates. Check GitHub URL!")
    end
end, "GET", "", {})

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
