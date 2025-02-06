local ox_target = exports.ox_target
ESX = exports['es_extended']:getSharedObject()
local lastOpened = {}

-- 🏆 Optimierung: Kein Dauerschleife-Thread! ox_target wird direkt geladen
for i, container in ipairs(Config.Containers) do
    ox_target:addBoxZone({
        coords = container.coords,
        size = vec3(1.5, 1.5, 2.0),
        rotation = 0.0,
        options = {
            {
                name = 'container_open_' .. i,
                event = 'container:breakOpen',
                icon = 'fa-solid fa-box-open',
                label = 'Container aufbrechen',
                distance = 2.0
            }
        }
    })
end

RegisterNetEvent('container:breakOpen', function(data)
    local containerIndex = tonumber(data.name:match('container_open_(%d+)'))
    if not containerIndex then return end

    -- 🏆 Optimierung: Kein unnötiges Timer-Check, wird nur geprüft wenn benutzt
    if lastOpened[containerIndex] and (GetGameTimer() - lastOpened[containerIndex]) < Config.Cooldown * 1000 then
        return lib.notify({title = 'Fehler', description = 'Dieser Container wurde kürzlich geöffnet!', type = 'error'})
    end

    local playerPed = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)

    -- 🧰 Überprüfen, ob der Spieler die Brechstange als Waffe führt (weapon_crowbar)
    if weaponHash ~= GetHashKey("WEAPON_CROWBAR") then
        return lib.notify({title = 'Fehler', description = 'Du brauchst eine Brechstange, um den Container zu öffnen!', type = 'error'})
    end

    -- 🎬 REALISTISCHE AUFBRECH-ANIMATION 🎬
    lib.requestAnimDict("missmechanic") -- 🏆 Optimierung: Nutzt lib.requestAnimDict für schnelles Laden
    TaskPlayAnim(playerPed, "missmechanic", "work2_base", 8.0, -8.0, Config.OpenDuration, 1, 0, false, false, false)

    -- ⏳ Fortschrittsbalken
    local success = lib.progressCircle({
        duration = Config.OpenDuration,
        position = 'middle',
        label = 'Container wird aufgebrochen...',
        useWhileDead = false,
        canCancel = true,
        disable = {move = true, car = true, combat = true}
    })

    ClearPedTasks(playerPed) -- Stoppt Animation nach der ProgressBar

    if success then
        TriggerServerEvent("container:serverBreakOpen", containerIndex)
        lastOpened[containerIndex] = GetGameTimer()

        -- Das Item wird nicht entfernt, weil wir keine Itemabfrage mehr brauchen
    else
        lib.notify({title = 'Abgebrochen', description = 'Du hast die Aktion abgebrochen!', type = 'error'})
    end
end)
