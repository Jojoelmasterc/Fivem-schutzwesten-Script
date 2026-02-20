local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterUsableItem('armor', function(source)
    TriggerClientEvent('kevlar:useVest', source)
end)

-- Item entfernen + Armor speichern
RegisterNetEvent('kevlar:applyVest', function(armor)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if xPlayer.getInventoryItem('armor').count <= 0 then return end

    xPlayer.removeInventoryItem('armor', 1)
    xPlayer.set('kevlarArmor', armor)
end)

-- Armor zurückgeben
ESX.RegisterServerCallback('kevlar:getArmor', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer and xPlayer.get('kevlarArmor') or 0)
end)

-- Armor löschen
RegisterNetEvent('kevlar:clearArmor', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.set('kevlarArmor', 0)
    end
end)