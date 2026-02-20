local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('kevlar:useVest', function()
    local ped = PlayerPedId()

    if GetPedArmour(ped) >= 100 then
        lib.notify({
            title = 'Schutzweste',
            description = 'Du trägst bereits eine Schutzweste.',
            type = 'error'
        })
        return
    end

    local success = lib.progressBar({
    duration = 5000,
    label = 'Schutzweste wird angelegt...',
    canCancel = true,
    disable = {
        move = false,
        car = true,
        combat = true
    },
    anim = {
        dict = 'clothingtie',
        clip = 'try_tie_negative_a'
    }
})

    if not success then
        return
    end

    SetPedArmour(ped, 100)

    -- Server: Item entfernen + Armor speichern
    TriggerServerEvent('kevlar:applyVest', 100)

    lib.notify({
        title = 'Schutzweste',
        description = 'Schutzweste angelegt.',
        type = 'success'
    })
end)

-- Armor beim Spawn wiederherstellen
AddEventHandler('playerSpawned', function()
    ESX.TriggerServerCallback('kevlar:getArmor', function(armor)
        if armor and armor > 0 then
            SetPedArmour(PlayerPedId(), armor)
        end
    end)
end)

-- Armor beim Tod löschen
AddEventHandler('esx:onPlayerDeath', function()
    SetPedArmour(PlayerPedId(), 0)
    TriggerServerEvent('kevlar:clearArmor')
end)