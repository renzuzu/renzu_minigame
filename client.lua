local open = false
local done = false
local res = false
RegisterNUICallback('reset', function(data, cb)
    Wait(200)
    open = false
    SetNuiFocus(false,false)
    SetNuiFocusKeepInput(false)
    done = true
    res = data.res
    Wait(2000)
    SendNUIMessage({type = "reset", content = true})
    done = false
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function Start(seconds,fa,option)
    if option == nil then option = {} end
    local t = {
        fa = fa or '<i class="fad fa-tasks-alt"></i>',
        seconds = seconds
    }
    local playinganimation = false
    SetNuiFocus(true,true)
    SetCursorLocation(0.05, 0.29)
    Wait(100)
    SetCursorLocation(0.05, 0.29)
    Wait(300)
    SendNUIMessage({type = "start", table = t})
    Wait(300)
    SetCursorLocation(0.05, 0.19)
    CreateThread(function()
        while not done do
            if IsControlPressed(0,169) then
                SendNUIMessage({type = "reset", content = true})
                done = true
            end
            Wait(0)
        end
    end)
    CreateThread(function()
        local player = PlayerPedId()
        if option.scenario ~= nil then
            TaskStartScenarioInPlace(player, option.scenario, 0, true)
            playinganimation = true
        else
            if option.dict ~= nil and option.name ~= nil then
                
                if option.flag == nil then
                    option.flag = 1
                end
                playinganimation = true
                RequestAnimDict( option.dict )
                while not HasAnimDictLoaded(option.dict) do Citizen.Wait(0) end
                TaskPlayAnim(player,option.dict, option.name, 1.0, -1.0, -1, 0, 1, true, true, true)
                while not done do
                    if not IsEntityPlayingAnim(PlayerPedId(), option.dict, option.name, 3) then
                        loadAnimDict(option.dict)
                        TaskPlayAnim(PlayerPedId(), option.dict, option.name, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                        Citizen.Wait(1500)
                        ClearPedTasks(PlayerPedId())
                    end
                    Citizen.Wait(1)
                end
            end
        end
    end)
    while not done do Wait(100) end
    local player = PlayerPedId()
    ClearPedTasks(player)
    return res
end

exports('Start', function(seconds,fa,o)
    return Start(seconds,fa,o)
end)

RegisterCommand('minigame', function(source, args, rawCommand) -- demo
    local o = {
        --scenario = 'WORLD_HUMAN_AA_COFFEE',
        dict = "random@shop_gunstore",
        name = "_idle_b",
        flag = 1,
    }
    local prog = exports.renzu_minigame:Start(o)
end)