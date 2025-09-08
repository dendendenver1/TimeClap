RegisterNetEvent('TimeClap:notifyAndFreezePlayers')
AddEventHandler('TimeClap:notifyAndFreezePlayers', function(freeze)
    local src = source
    local players = GetPlayers()
    
    for _, player in ipairs(players) do
        if tonumber(player) ~= src then
            if freeze then
                TriggerClientEvent('chat:addMessage', tonumber(player), {
                    args = { '^3[SYSTEM]', Config.TimeFrozenMessage }
                })
            end
            
            TriggerClientEvent('TimeClap:setFreezeState', tonumber(player), freeze)
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
