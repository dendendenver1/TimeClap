local State = {timeFrozen = false}

local function isPlayerAllowed()
    local identifiers = GetPlayerIdentifiers(PlayerId())
    for _, identifier in ipairs(identifiers) do
        if Config.AllowedIdentifiers[identifier] then
            return true
        end
    end
    return false
end

local function playClapAnimation()
    local playerPed = PlayerPedId()
    
    RequestAnimDict(Config.Animations.dict)
    while not HasAnimDictLoaded(Config.Animations.dict) do
        Wait(0)
    end
    
    TaskPlayAnim(playerPed, Config.Animations.dict, Config.Animations.name, 8.0, -8.0, -1, 1, 0, false, false, false)
    
    return GetGameTimer() + 1500
end

local function toggleTimeStop()
    if not isPlayerAllowed() then
        TriggerEvent('chat:addMessage', { args = { '^1[SYSTEM]', 'You do not have permission to use this command.' } })
        return
    end
    
    State.timeFrozen = not State.timeFrozen
    
    if State.timeFrozen then
        local clapTime = playClapAnimation()
        
        CreateThread(function()
            while GetGameTimer() < clapTime do
                Wait(0)
            end
            
            TriggerServerEvent('TimeClap:notifyAndFreezePlayers', State.timeFrozen)
            TriggerEvent('chat:addMessage', { args = { '^2[SYSTEM]', 'Time has been frozen for everyone else.' } })
        end)
    else
        TriggerServerEvent('TimeClap:notifyAndFreezePlayers', State.timeFrozen)
        TriggerEvent('chat:addMessage', { args = { '^2[SYSTEM]', 'Time has been unfrozen for everyone.' } })
    end
end

RegisterCommand('timestop', function()
    toggleTimeStop()
end, false)

RegisterNetEvent('TimeClap:setFreezeState')
AddEventHandler('TimeClap:setFreezeState', function(freeze)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, freeze)
    SetEntityInvincible(playerPed, freeze)
    
    if freeze then
        ClearPedTasksImmediately(playerPed)
        SetPedCanRagdoll(playerPed, false)
    else
        SetPedCanRagdoll(playerPed, true)
    end
end)
