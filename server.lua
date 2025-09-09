local function isPlayerAllowed(src)
    local identifiers = GetPlayerIdentifiers(src)
    for _, identifier in ipairs(identifiers) do
        if Config.AllowedIdentifiers[identifier] then
            return true
        end
    end
    return false
end

RegisterNetEvent('TimeClap:requestPermissionCheck')
AddEventHandler('TimeClap:requestPermissionCheck', function()
    local src = source
    local hasPermission = isPlayerAllowed(src)
    TriggerClientEvent('TimeClap:permissionResult', src, hasPermission)
end)

RegisterNetEvent('TimeClap:notifyAndFreezePlayers')
AddEventHandler('TimeClap:notifyAndFreezePlayers', function(freeze)
    local src = source
    local players = GetPlayers()
    
    for _, player in ipairs(players) do
        local playerId = tonumber(player)
        if playerId ~= src then
            -- Notify other players about the freeze
            if freeze then
                TriggerClientEvent('chat:addMessage', playerId, {
                    args = { '^3[SYSTEM]', Config.TimeFrozenMessage }
                })
            end
            
            -- Apply freeze state to all other players
            TriggerClientEvent('TimeClap:setFreezeState', playerId, freeze)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    
    RegisterCommand('timestop', function(source, args, rawCommand)
    end, false)
    
    print('^2[TimeClap] ^7TimeClap command has been loaded. Use /timestop to freeze time.')
end)
