local ox_target = exports.ox_target
ESX = exports['es_extended']:getSharedObject()
local lastOpened = {}

-- Container-Zonen laden
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

    -- Cooldown prüfen
    if lastOpened[containerIndex] and (GetGameTimer() - lastOpened[containerIndex]) < Config.Cooldown * 1000 then
        return lib.notify({title = 'Fehler', description = 'Dieser Container wurde kürzlich geöffnet!', type = 'error'})
    end

    local playerPed = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)

    -- Prüfen, ob der Spieler eine Brechstange hat
    if weaponHash ~= GetHashKey("WEAPON_CROWBAR") then
        return lib.notify({title = 'Fehler', description = 'Du brauchst eine Brechstange, um den Container zu öffnen!', type = 'error'})
    end

    -- Animationsanforderung
    lib.requestAnimDict("missmechanic")
    TaskPlayAnim(playerPed, "missmechanic", "work2_base", 8.0, -8.0, Config.OpenDuration, 1, 0, false, false, false)

    -- Fortschrittsbalken
    local success = lib.progressCircle({
        duration = Config.OpenDuration,
        position = 'middle',
        label = 'Container wird aufgebrochen...',
        useWhileDead = false,
        canCancel = true,
        disable = {move = true, car = true, combat = true}
    })

    ClearPedTasks(playerPed)

    if success then
        TriggerServerEvent("container:serverBreakOpen", containerIndex)
        lastOpened[containerIndex] = GetGameTimer()
    else
        lib.notify({title = 'Abgebrochen', description = 'Du hast die Aktion abgebrochen!', type = 'error'})
    end
end)
