local blips, currentCustody, serviceBlips  = {}, {}, {}
local disableDispatch, showing, inCustody, dragged, dragging, cuffing, uncuffing, canShoot =  false, false, false, false, false, false, false, false

Citizen.CreateThread(function()
    while PW == nil do
        TriggerEvent('pw:getSharedObject', function(obj) PW = obj end)
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('pw:characterLoaded')
AddEventHandler('pw:characterLoaded', function(data)
    if data then
        playerData = data
        loadBlips()
        
        for k, v in pairs(Config.DisableDispatch) do
            EnableDispatchService(v, false)
        end
        SetMaxWantedLevel(0)
        
        PW.TriggerServerCallback('pw_police:server:sendCustody', function(list)
            currentCustody = list
        end)
        
        characterLoaded = true
        disableDispatchStart()
        CheckForEmergencyBlips()
        if playerData.job.job == 'ems' or playerData.job.job == 'police' then
            TriggerServerEvent('pw_police:server:getDuties')
        end
        SetIgnoreLowPriorityShockingEvents(PlayerId(), false)
    end
end)

RegisterNetEvent('pw:characterUnLoaded')
AddEventHandler('pw:characterUnLoaded', function()
    characterLoaded = false
    deleteBlips()
    disableDispatch = false
    playerData = nil
    serviceBlips = {}
    TriggerServerEvent('pw_police:server:deleteBlip')
end)

RegisterNetEvent('pw:setJob')
AddEventHandler('pw:setJob', function(data)
    if characterLoaded and playerData then
        playerData.job = data
        CheckForEmergencyBlips()
    end    
end)

RegisterNetEvent('pw:toggleDuty')
AddEventHandler('pw:toggleDuty', function(toggle)
    if characterLoaded and playerData then
        playerData.job.duty = toggle
        showing = false

        CheckForEmergencyBlips()
    end
end)

function CheckForEmergencyBlips()
    if playerData.job.duty and (playerData.job.job == 'police' or playerData.job.job == 'ems') then
        TriggerServerEvent('pw_police:server:createBlip', playerData.job.job)
    elseif not playerData.job.duty and (playerData.job.job == 'police' or playerData.job.job == 'ems') then
        TriggerServerEvent('pw_police:server:deleteBlip')
    end
end

RegisterNetEvent('pw_police:client:createBlip')
AddEventHandler('pw_police:client:createBlip', function(id, job)
    local dude = GetPlayerFromServerId(id)
    TriggerEvent('pw_police:client:deleteBlip', dude)
    local dudePed = GetPlayerPed(dude)
    local spriteColor = (job == 'police' and 3 or 1)
    serviceBlips[dude] = AddBlipForEntity(dudePed)
    SetBlipSprite(serviceBlips[dude], 1)
    ShowHeadingIndicatorOnBlip(serviceBlips[dude], true) 
    SetBlipRotation(serviceBlips[dude], math.ceil(GetEntityHeading(dudePed)))
    SetBlipScale(serviceBlips[dude], 0.8) 
    SetBlipAsShortRange(serviceBlips[dude], false)
    SetBlipColour(serviceBlips[dude], spriteColor)
    SetBlipHiddenOnLegend(serviceBlips[dude], true)
end)

RegisterNetEvent('pw_police:client:deleteBlip')
AddEventHandler('pw_police:client:deleteBlip', function(id)
local dude = GetPlayerFromServerId(id)
    if serviceBlips[dude] ~= nil then
        if DoesBlipExist(serviceBlips[dude]) then
            RemoveBlip(serviceBlips[dude])
            serviceBlips[dude] = nil
        end
    end
end)

function loadBlips()
    for k, v in pairs(Config.Stations) do
        blips[k] = AddBlipForCoord(v.location.x, v.location.y, v.location.z)
        SetBlipSprite(blips[k], Config.Blips.type)
        SetBlipDisplay(blips[k], 4)
        SetBlipScale  (blips[k], Config.Blips.scale)
        SetBlipColour (blips[k], Config.Blips.color)
        SetBlipAsShortRange(blips[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Police Station")
        EndTextCommandSetBlipName(blips[k])
    end
end

function deleteBlips()
    for k, v in pairs(blips) do
        if DoesBlipExist(v) then
            RemoveBlip(v)
        end
    end
end

function disableDispatchStart()
    disableDispatch = true
    Citizen.CreateThread(function()
        while disableDispatch do
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed)
            ClearAreaOfCops(playerCoords.x, playerCoords.y, playerCoords.z, 100.0)
            RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
            RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
            RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
            Citizen.Wait(1)
        end
    end)
end

function DrawText(type, var, station)
    local title, message, icon
    
    if type == 'duty' then
        title = "Police Duty"
        message = "<span style='font-size:25px'>Sign <b><span class='text-"..(playerData.job.duty and "danger'>Off" or "success'>On").."</span></b> Duty</span>"
        icon = "fad fa-clipboard"
    elseif type == 'garage' then
        title = "Garage"
        message = "<span style='font-size:20px'>Access <b><span class='text-primary'>Police Garage</span></b></span>"
        icon = "fad fa-garage-car"
    elseif type == 'helipad' then
        title = "Garage"
        message = "<span style='font-size:20px'>Access <b><span class='text-primary'>Police Helipad</span></b></span>"
        icon = "fad fa-helicopter"
    elseif type == 'publicRecords' then
        title = "Public Records"
        message = "<span style='font-size:20px'>Access <b><span class='text-primary'>Public Records</span></b></span>"
        icon = "fad fa-desktop-alt"
    elseif type == 'evidence' then
        title = "Evidence"
        message = "<span style='font-size:20px'>Process <b><span class='text-primary'>Evidence</span></b></span>"
        icon = "fad fa-dna"
    elseif type == 'evidenceStorage' then
        TriggerEvent('pw_inventory:client:secondarySetup', "evidence", { type = 17, owner = station, name = "Evidence Storage" })
        title = "Evidence"
        message = "<span style='font-size:20px'><span class='text-primary'>Evidence Storage</span></b></span>"
        icon = "fad fa-dna"
    elseif type == 'evidenceTrash' then
        TriggerEvent('pw_inventory:client:secondarySetup', "evidenceTrash", { type = 16, owner = station, name = "Evidence Trash" })
        title = "Evidence Trash"
        message = "<span style='font-size:20px'><span class='text-danger'>Evidence Trash</span></b></span>"
        icon = "fad fa-trash-alt"
    end

    if title ~= nil and message ~= nil and icon ~= nil then
        TriggerEvent('pw_drawtext:showNotification', { title = title, message = message, icon = icon })
    end

    Citizen.CreateThread(function()
        while showing == var do
            Citizen.Wait(1)
            if IsControlJustPressed(0, 38) then
                if type == 'duty' then
                    TriggerServerEvent('pw_police:server:toggleDuty')
                elseif type == 'garage' then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        ParkVehicle(station)
                    else
                        OpenGarage(station)
                    end
                elseif type == 'helipad' then
                    local foundHeli = CheckHeli(station)
                    if foundHeli and foundHeli ~= 0 then
                        ParkHeli(foundHeli, station)
                    elseif foundHeli == 0 then
                        exports.pw_notify:SendAlert('error', 'There\'s a vehicle in the way that\'s not an aircraft', 5000)
                    else
                        HelipadMenu(station)
                    end
                elseif type == 'publicRecords' then
                    print("OPEN PUBLIC RECORDS")
                elseif type == 'evidence' then
                    print("OPEN EVIDENCE PROCESSING")
                end
            end
        end
    end)
end

function HelipadMenu(station)
    local menu = {}

    for k,v in pairs(Config.Stations[station].markers.helipad.availableVehicles) do
        if playerData.job.grade_level >= k then
            for i = 1, #v do
                table.insert(menu, { ['label'] = GetVehNameByModel(v[i]), ['action'] = 'pw_police:client:spawnHeli', ['value'] = { ['model'] = v[i], ['station'] = station }, ['triggertype'] = 'client', ['color'] = 'primary' })
            end
        end
    end

    TriggerEvent('pw_interact:generateMenu', menu, "Police Helipad")
end

function ParkHeli(heli, station)
    local playerPed = PlayerPedId()
    local found = false
    
    for k,v in pairs(Config.Stations[station].markers.helipad.availableVehicles) do
        for i = 1, #v do
            if GetHashKey(v[i]) == GetEntityModel(heli) then
                found = true
                break
            end
        end
    end

    if found then
        local vin = PW.Vehicles.GetVinNumber(PW.Game.GetVehicleProperties(heli).plate)
        TriggerServerEvent('pw_keys:revokeKeys', 'Vehicle', vin, true, nil)
        SetEntityAsMissionEntity(heli, true, true)
        DeleteEntity(heli)
        exports.pw_notify:SendAlert('inform', 'Aircraft parked successfully.', 5000)
    else
        exports.pw_notify:SendAlert('error', 'This vehicle doesn\'t belong to this Station, you can\'t park it here.', 5000)
    end
end

function CheckHeli(station)
    local playerPed = PlayerPedId()
    local allowedClass = { 15, 16, 17, 18, 19 }
    local rayHandle = StartShapeTestBox(Config.Stations[station].markers.helipad.spawnCoords.x, Config.Stations[station].markers.helipad.spawnCoords.y, Config.Stations[station].markers.helipad.spawnCoords.z, 15.0, 15.0, 8.0, 0.0, 0.0, 0.0, true, 2, 0)
    local _, hit, _, _, heli = GetShapeTestResult(rayHandle)
    if hit then
        local foundClass = GetVehicleClass(heli)
        local canPark = false
        for i = 1, #allowedClass do
            if foundClass == allowedClass[i] then
                canPark = true
                break
            end
        end
        if canPark then
            return heli
        elseif foundClass > 0 then
            return 0
        end
    else
        return false
    end
end

function ParkVehicle(station)
    local playerPed = PlayerPedId()
    local found = false
    
    for k,v in pairs(Config.Stations[station].markers.garage.availableVehicles) do
        for i = 1, #v do
            if GetHashKey(v[i]) == GetEntityModel(GetVehiclePedIsIn(playerPed)) then
                found = true
                break
            end
        end
    end

    if found then
        local pedVeh = GetVehiclePedIsIn(playerPed)
        local vin = PW.Vehicles.GetVinNumber(PW.Game.GetVehicleProperties(pedVeh).plate)
        TriggerServerEvent('pw_keys:revokeKeys', 'Vehicle', vin, true, nil)
        SetEntityAsMissionEntity(pedVeh, true, true)
        DeleteEntity(pedVeh)
    else
        exports.pw_notify:SendAlert('error', 'This vehicle doesn\'t belong to this Station, you can\'t park it here.', 5000)
    end
end

function OpenGarage(station)
    local menu = {}

    for k,v in pairs(Config.Stations[station].markers.garage.availableVehicles) do
        if playerData.job.grade_level >= k then
            for i = 1, #v do
                table.insert(menu, { ['label'] = GetVehNameByModel(v[i]), ['action'] = 'pw_police:client:spawnVeh', ['value'] = { ['model'] = v[i], ['station'] = station }, ['triggertype'] = 'client', ['color'] = 'primary' })
            end
        end
    end

    TriggerEvent('pw_interact:generateMenu', menu, "Police Garage")
end

RegisterNetEvent('pw_police:client:spawnHeli')
AddEventHandler('pw_police:client:spawnHeli', function(data)
    local coords = Config.Stations[data.station].markers.helipad.spawnCoords
    PW.Game.SpawnOwnedVehicle(data.model, coords, coords.h, function(spawnedVeh)
        local props = PW.Game.GetVehicleProperties(spawnedVeh)
        PW.TriggerServerCallback('pw_vehicleshop:server:registerPotentialVin', function(vin)
            TriggerServerEvent('pw_keys:issueKey', "Vehicle", vin, false, true)
        end, props, spawnedVeh)
    end)
end)

RegisterNetEvent('pw_police:client:spawnVeh')
AddEventHandler('pw_police:client:spawnVeh', function(data)
    local coords = Config.Stations[data.station].markers.garage.spawnCoords

    local cV = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    if cV == 0 or cV == nil then
        PW.Game.SpawnOwnedVehicle(data.model, coords, coords.h, function(spawnedVeh)
            local props = PW.Game.GetVehicleProperties(spawnedVeh)
            PW.TriggerServerCallback('pw_vehicleshop:server:registerPotentialVin', function(vin)
                TriggerServerEvent('pw_keys:issueKey', "Vehicle", vin, false, true)
            end, props, spawnedVeh)
        end)
    else
        exports.pw_notify:SendAlert('error', 'There\'s a vehicle blocking the vehicle exit', 5000)
    end
end)

function GetVehNameByModel(model)
    local hashVehicule = (type(model) ~= "number" and GetHashKey(model) or model)
    hashVehicule = string.gsub(GetDisplayNameFromVehicleModel(hashVehicule), "%s", "_")
    local vehicleName = GetLabelText(hashVehicule)
    if vehicleName == "NULL" or vehicleName == "CARNOTFOUND" then
        vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    end
    return vehicleName
end

function jailPlayer(loc, time) 
    if loc ~= nil then
        if Config.PhotoShoots[loc] == nil then
            loc = 1
        end
        local playerPed = GetPlayerPed(-1)
        local playerCurrentCoords = GetEntityCoords(playerPed)
        local doingPhotoshoot = true

        local currentLocation = Config.PhotoShoots[loc]
        if currentLocation ~= nil then
            for k, v in pairs(currentLocation.neededProps) do
                RequestModel(GetHashKey(v))
                while not HasModelLoaded(GetHashKey(v)) do
                    Citizen.Wait(1)
                end
            end

            local boardHash = GetHashKey("prop_police_id_board")
            local overlayHash = GetHashKey("prop_police_id_text")


            RequestModel(currentLocation.officerModel)

            while not HasModelLoaded(currentLocation.officerModel) do
                Citizen.Wait(1)
            end
            local policeOfficer = CreatePed(5, currentLocation.officerModel, currentLocation.officerCoords.x, currentLocation.officerCoords.y, currentLocation.officerCoords.z, currentLocation.officerCoords.h, false)
            local shootCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", currentLocation.officerCoords.x, currentLocation.officerCoords.y, currentLocation.officerCoords.z+1.3, 0.00, 0.00, 0.00, 70.00, false, 0)
            PointCamAtCoord(shootCam, currentLocation.playerCoords.x, currentLocation.playerCoords.y, currentLocation.playerCoords.z)
            TaskStartScenarioInPlace(policeOfficer, "WORLD_HUMAN_PAPARAZZI", -1, false)

            Citizen.CreateThread(function()
                while doingPhotoshoot do
                    DisableControlAction(0, 24, true) -- Attack
                    DisableControlAction(0, 257, true) -- Attack 2
                    DisableControlAction(0, 25, true) -- Aim
                    DisableControlAction(0, 263, true) -- Melee Attack 1
                    DisableControlAction(0, 32, true) -- W
                    DisableControlAction(0, 34, true) -- A
                    DisableControlAction(0, 31, true) -- S
                    DisableControlAction(0, 30, true) -- D
                    DisableControlAction(0, 45, true) -- Reload
                    DisableControlAction(0, 22, true) -- Jump
                    DisableControlAction(0, 44, true) -- Cover
                    DisableControlAction(0, 37, true) -- Select Weapon
                    DisableControlAction(0, 23, true) -- Also 'enter'?
                    DisableControlAction(0, 288,  true) -- Disable phone
                    DisableControlAction(0, 289, true) -- Inventory
                    DisableControlAction(0, 170, true) -- Animations
                    DisableControlAction(0, 167, true) -- Job
                    DisableControlAction(0, 0, true) -- Disable changing view
                    DisableControlAction(0, 26, true) -- Disable looking behind
                    DisableControlAction(0, 73, true) -- Disable clearing animation
                    DisableControlAction(2, 199, true) -- Disable pause screen
                    DisableControlAction(0, 59, true) -- Disable steering in vehicle
                    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
                    DisableControlAction(2, 36, true) -- Disable going stealth
                    DisableControlAction(0, 47, true)  -- Disable weapon
                    DisableControlAction(0, 264, true) -- Disable melee
                    DisableControlAction(0, 257, true) -- Disable melee
                    DisableControlAction(0, 140, true) -- Disable melee
                    DisableControlAction(0, 141, true) -- Disable melee
                    DisableControlAction(0, 142, true) -- Disable melee
                    DisableControlAction(0, 143, true) -- Disable melee
                    DisableControlAction(0, 75, true)  -- Disable exit vehicle
                    DisableControlAction(27, 75, true) -- Disable exit vehicle
                    Citizen.Wait(1)
                end
            end)

            Citizen.CreateThread(function()
                DoScreenFadeOut(1500)
                Citizen.Wait(1501)
                exports.pw_hud:toggleHud(false)
                SetEntityCoords(playerPed, currentLocation.playerCoords.x, currentLocation.playerCoords.y, currentLocation.playerCoords.z, 0.0, 0.0, 0.0, false)
                Citizen.Wait(500)
                local board = CreateObject(boardHash, currentLocation.playerCoords.x, currentLocation.playerCoords.y, currentLocation.playerCoords.z, false, true, false)
                local overlay = CreateObject(overlayHash, currentLocation.playerCoords.x, currentLocation.playerCoords.y, currentLocation.playerCoords.z, false, true, false)
                AttachEntityToEntity(overlay, board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                SetModelAsNoLongerNeeded(boardHash)
                SetModelAsNoLongerNeeded(overlayHash)
                ClearPedWetness(playerPed)
                ClearPedBloodDamage(playerPed)
                ClearPlayerWantedLevel(PlayerId())
                SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"), 1)
                AttachEntityToEntity(board, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
                local dict = "mp_character_creation@lineup@male_a"
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Citizen.Wait(10)
                end

                local board_scaleform = LoadScaleform("mugshot_board_01")
                local handle = CreateNamedRenderTargetForModel("ID_Text", overlayHash)

                Citizen.CreateThread(function()
                    while handle do
                        HideHudAndRadarThisFrame()
                        SetTextRenderId(handle)
                        Set_2dLayer(4)
                        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
                        DrawScaleformMovie(board_scaleform, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0)
                        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
                        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        
                        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
                        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
                        if playerData then
                            CallScaleformMethod(board_scaleform, 'SET_BOARD', "Sentenced", playerData.name, "PixelWorld", time.." Months", 0, 1337, 116)
                        end
                        Citizen.Wait(0)
                    end
                end)

                holdingSign = true
                TaskPlayAnim(playerPed, dict, "loop_raised", 8.0, 8.0, -1, 49, 0, false, false, false)
                SetEntityHeading(policeOfficer, currentLocation.officerCoords.h)
                SetEntityHeading(playerPed, currentLocation.playerCoords.h)
                TaskLookAtEntity(playerPed, policeOfficer, -1, 2048, 3)
                SetCamActive(shootCam, true)
                RenderScriptCams(true, true, 0, true, true)
                Citizen.Wait(1501)
                DoScreenFadeIn(1500)
                Citizen.Wait(5000)
                SetEntityHeading(playerPed, currentLocation.playerCoords.h+90.0)
                SetEntityHeading(policeOfficer, currentLocation.officerCoords.h)
                Citizen.Wait(5000)
                SetEntityHeading(playerPed, currentLocation.playerCoords.h-90.0)
                SetEntityHeading(policeOfficer, currentLocation.officerCoords.h)
                Citizen.Wait(5000)
                SetEntityHeading(playerPed, currentLocation.playerCoords.h)
                SetEntityHeading(policeOfficer, currentLocation.officerCoords.h)
                Citizen.Wait(5000)
                ClearPedTasks(policeOfficer)
                TaskLookAtEntity(policeOfficer, playerPed, -1, 2048, 3)
                Citizen.Wait(1000)
                SetEntityHeading(policeOfficer, currentLocation.officerCoords.h)
                ClearPedSecondaryTask(GetPlayerPed(-1))
                DeleteObject(overlay)
                DeleteObject(board)
                holdingSign = false
                DoScreenFadeOut(1501)
                Citizen.Wait(1500)
                doingPhotoshoot = false
                handle = nil
                RenderScriptCams(false, false, 0, false, false)
                DestroyCam(shootCam, false)
                DeletePed(policeOfficer)
                TriggerEvent('pw_prison:client:sendToPrison', time)
                exports.pw_hud:toggleHud(true)
            end)
        end
    end
end

RegisterNetEvent('pw_police:client:sendToPrison')
AddEventHandler('pw_police:client:sendToPrison', function(time, officer)
    for k, v in pairs(Config.Stations) do
        local playerPed = GetPlayerPed(-1)
        local officerPed = GetPlayerPed(GetPlayerFromServerId(officer))
        local officerCoords = GetEntityCoords(officerPed)
        local playerCoords = GetEntityCoords(playerPed)

        local distance = #(officerCoords - vector3(v.location.x, v.location.y, v.location.z))
        local plyDistance = #(officerCoords - vector3(v.location.x, v.location.y, v.location.z))
        if distance < 200.0 and plyDistance < 200.0 then
            jailPlayer(k, time)
            break
        end
    end
end)

RegisterNetEvent('pw_police:client:openMdt')
AddEventHandler('pw_police:client:openMdt', function()
    if characterLoaded and playerData then 
        startTabletAnim()
    end
end)

RegisterNetEvent('pw_police:client:getCustody')
AddEventHandler('pw_police:client:getCustody', function(peds)
    currentCustody = peds
end)

function HandleCustody(state)
    inCustody = state
    TriggerServerEvent('pw_police:server:handleCustody', inCustody)
end

RegisterNetEvent('pw_police:client:draggingPlayer')
AddEventHandler('pw_police:client:draggingPlayer', function(state, target)
    if state then
        dragging = target
    else
        dragging = false
    end
end)

RegisterNetEvent('pw_police:client:dragPlayer')
AddEventHandler('pw_police:client:dragPlayer', function(cop, force)
    if not inCustody then return; end
    local copPed = GetPlayerPed(GetPlayerFromServerId(cop))
    local targetPed = PlayerPedId()

    if force then
        dragged = true
        AttachEntityToEntity(targetPed, copPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    else
        if dragged then
            dragged = false
            DetachEntity(targetPed, true, false)
        else
            dragged = true
            AttachEntityToEntity(targetPed, copPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end
    end
    
    TriggerServerEvent('pw_police:server:draggingPlayer', cop, dragged)
end)

function escortPlayer()
    if dragged then return; end
    local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < Config.DragRadiusCheck then
        TriggerServerEvent('pw_police:server:dragPlayer', GetPlayerServerId(closestPlayer))
    end    
end

RegisterNetEvent('pw_police:client:sendToCar')
AddEventHandler('pw_police:client:sendToCar', function(veh, seat)
    TaskWarpPedIntoVehicle(PlayerPedId(), NetworkGetEntityFromNetworkId(veh), seat)
end)

RegisterNetEvent('pw_police:client:leaveCar')
AddEventHandler('pw_police:client:leaveCar', function(veh)
    TaskLeaveVehicle(PlayerPedId(), NetworkGetEntityFromNetworkId(veh), 16)
end)

function putInVehicle()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed, true)
    local targetPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 3.0, -0.5)
    local rayCast = StartShapeTestCapsule(pos.x, pos.y, pos.z, targetPos.x, targetPos.y, targetPos.z, 2, 10, playerPed, 7)
    local _,hit,_,_,veh = GetShapeTestResult(rayCast)
    if hit and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
        local vNet = VehToNet(veh)
        local maxSeats = GetVehicleMaxNumberOfPassengers(veh)
        if dragging then
            if AreAnyVehicleSeatsFree(veh) then
                local freeSeat
                for i = maxSeats - 1, 0, -1 do
                    if IsVehicleSeatFree(veh, i) then
                        freeSeat = i
                        break
                    end
                end

                if freeSeat then
                    TriggerServerEvent('pw_police:server:sendToCar', dragging, vNet, freeSeat)
                    
                    TriggerServerEvent('pw_police:server:dragPlayer', dragging)
                end
            end
        else
            if GetVehicleNumberOfPassengers(veh) > 0 then
                for i = maxSeats - 1, 0, -1 do
                    if not IsVehicleSeatFree(veh, i) then
                        local pedSitting = GetPedInVehicleSeat(veh, i)
                        local pedId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(pedSitting))
                        
                        local isInCustody = IsInCustody(pedId)
                        if isInCustody then
                            TriggerServerEvent('pw_police:server:leaveCar', pedId, vNet)
                            Wait(1000)
                            if currentCustody[isInCustody].type == 'hard' then
                                TriggerServerEvent('pw_police:server:dragPlayer', pedId, true)
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

RegisterNetEvent('pw_police:client:uncuffPlayer')
AddEventHandler('pw_police:client:uncuffPlayer', function()
    uncuffing = true
    local playerPed = PlayerPedId()
    
    Citizen.Wait(250)
    LoadAnimDict('mp_arresting')
    TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    TriggerEvent('pw:notification:SendAlert', {type = "inform", text = "You have uncuffed a citizen.", length = 5000})
    ClearPedTasks(playerPed)
    uncuffing = false
end)

RegisterNetEvent('pw_police:client:getUncuffed')
AddEventHandler('pw_police:client:getUncuffed', function(playerHeading, playerCoords, playerLocation)
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(playerCoords + playerLocation * 1.0)
    SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, playerHeading)
    Citizen.Wait(250)
    LoadAnimDict('mp_arresting')
    TaskPlayAnim(playerPed, 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    inCustody = false
    TriggerEvent('pw:notification:SendAlert', {type = "inform", text = "Your cuffs have been removed by the Police.", length = 5000})
    ClearPedTasks(playerPed)
end)

RegisterNetEvent('pw_police:client:cuffPlayer')
AddEventHandler('pw_police:client:cuffPlayer', function(cuffType)
    cuffing = true
    local playerPed = PlayerPedId()
    
    Citizen.Wait(250)
    LoadAnimDict('mp_arrest_paired')
    TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
    TriggerEvent('pw:notification:SendAlert', {type = "inform", text = "You have placed a citizen into Police Custody ("..(cuffType == 'soft' and "Soft Cuff" or "Hard Cuff")..")", length = 5000})
    cuffing = false
end)

RegisterNetEvent('pw_police:client:getCuffed')
AddEventHandler('pw_police:client:getCuffed', function(playerHeading, playerCoords, playerLocation, cuffType)
    inCustody = cuffType
    PutCuffs()

    local playerPed = GetPlayerPed(-1)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    
    local x, y, z = table.unpack(playerCoords + playerLocation * 1.0)
    SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, playerHeading)
    Citizen.Wait(250)
    LoadAnimDict('mp_arrest_paired')
    TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
    Citizen.Wait(3760)
    LoadAnimDict('mp_arresting')
    TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    TriggerEvent('pw:notification:SendAlert', {type = "inform", text = "You have been placed into Police Custody ("..(cuffType == 'soft' and "Soft Cuff" or "Hard Cuff")..")", length = 5000})
end)

RegisterNetEvent('pw_police:client:checkDragging')
AddEventHandler('pw_police:client:checkDragging', function(id)
    if dragging == id then dragging = false; end
end)

function arrestPlayer(cuffType)
    if dragging or dragged or cuffing or uncuffing then return; end
    
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    local playerLocation = GetEntityForwardVector(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    if PW ~= nil then
        local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= Config.SoftRadiusCheck then
            TriggerServerEvent('pw_police:server:arrestCitizen', GetPlayerServerId(closestPlayer), playerHeading, playerCoords, playerLocation, cuffType)
        end
    end
end

function IsInCustody(id)
    for k,v in pairs(currentCustody) do
        if v.id == id then
            return k
        end
    end
    return false
end

function PutCuffs()
    local playerPed = PlayerPedId()
    Citizen.CreateThread(function()
        while inCustody do
            Citizen.Wait(0)
            if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
                TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            end

            if inCustody == 'hard' then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S
                DisableControlAction(0, 30, true) -- D
            end

            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
        ClearPedTasks(playerPed)
    end)
end

-- DISPATCHING CRIMES --

---- Vehicle Theft
function BreakingIntoVeh(veh, seat)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestPeds = PW.Game.GetClosestPedsInArea(playerCoords, Config.ClosePedsRadius)
    if closestPeds ~= nil and closestPeds[1] then
        for k,v in pairs(closestPeds) do
            math.randomseed(GetGameTimer())
            local chance = math.random(1,100)
            if chance <= Config.AlertChance then
                if not IsPedAPlayer(v) and not IsPedFatallyInjured(v) then
                    local model = GetVehNameByModel(GetEntityModel(veh))
                    local color, _ = GetVehicleColours(veh)
                    color = exports.pw_base:getVehicleColor(color)
                    Wait(5000)
                    TriggerEvent('pw_chat:client:DoPoliceDispatch', '10-69', 'Vehicle: ' .. model .. " | Color: " .. color , playerData.sex)
                    break
                end
            end
        end
    end
end

---- Killing
AddEventHandler('DamageEvents:PedKilledByPlayer', function(pedKilled, attackerId, weaponHash, isMelee)
    if IsPedAPlayer(pedKilled) then
        if attackerId == PlayerId() and pedKilled ~= PlayerPedId() then
            local playerCoords = GetEntityCoords(GetPlayerPed(attackerId))
            local closestPeds = PW.Game.GetClosestPedsInArea(playerCoords, Config.ClosePedsRadius)
            if closestPeds ~= nil and closestPeds[1] then
                for k,v in pairs(closestPeds) do
                    math.randomseed(GetGameTimer())
                    local chance = math.random(1,100)
                    if chance <= Config.AlertChance then
                        if not IsPedAPlayer(v) and not IsPedFatallyInjured(v) then
                            local _, usedWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
                            local armed = (isMelee and 'unnarmed' or 'carrying a ' .. exports.pw_weapons:retreiveWeaponByHash(usedWeapon).label)
                            TriggerEvent('pw_chat:client:DoPoliceDispatch', '4-20', 'Suspect is ' .. armed, playerData.sex)
                            break
                        end
                    end
                end
            end
        end
    end
end)

---- Gun firing & Gun possession
local looping, weaponCooldown, hasWeapon, gunPossessionTimer = false, false, false, 0
local recentlyReported = { ['firing'] = false, ['possession'] = false, ['fight'] = { ['victim'] = 0, ['attacker'] = 0 } }
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if characterLoaded and playerData then
            local playerPed = PlayerPedId()
            --if playerData.job.job ~= 'police' or (playerData.job.job == 'police' and not playerData.job.duty) then
                if IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and not recentlyReported['firing'] and not canShoot then
                    local _, curWeapon = GetCurrentPedWeapon(playerPed, 1)
                    NPCReport('firing', { ['weapon'] = curWeapon })
                elseif not IsPedShooting(playerPed) and IsPedArmed(playerPed, 4) then
                    if not hasWeapon then hasWeapon = true; end
                    if not looping then
                        looping = true
                        Citizen.CreateThread(function()
                            while hasWeapon and not weaponCooldown and not recentlyReported['possession'] and not canShoot do
                                Citizen.Wait(1000)
                                gunPossessionTimer = gunPossessionTimer + 1
                                if gunPossessionTimer >= Config.PossessionTimer then
                                    local _, curPosWeapon = GetCurrentPedWeapon(playerPed, 1)
                                    NPCReport('possession', { ['weapon'] = curPosWeapon })
                                end
                            end
                            looping = false
                        end)
                    end
                elseif not IsPedArmed(playerPed, 4) then
                    if hasWeapon then
                        Citizen.CreateThread(function()
                            weaponCooldown = true
                            Citizen.Wait(5000)
                            if not IsPedArmed(playerPed, 4) then
                                hasWeapon = false
                                gunPossessionTimer = 0
                            end
                            weaponCooldown = false
                        end)
                    end
                end
            --end
        end
    end
end)

function NPCReport(crime, data)
    if playerData ~= nil then
        local code, message
        if crime == 'firing' then
            code = '10-99'
            message = 'Suspect seen firing a ' .. exports.pw_weapons:retreiveWeaponByHash(data.weapon).label
        elseif crime == 'possession' then
            code = '10-00'
            message = 'Suspect seen holding a ' .. exports.pw_weapons:retreiveWeaponByHash(data.weapon).label
        elseif crime == 'fight' then
            code = '10-01'
            message = 'Physical fight'
        end
        
        math.randomseed(GetGameTimer())
        local chance = math.random(1,100)
        if chance <= Config.AlertChance then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local closestPeds = PW.Game.GetClosestPedsInArea(playerCoords, Config.ClosePedsRadius)
            if closestPeds ~= nil and closestPeds[1] then
                for k,v in pairs(closestPeds) do
                    if not IsPedAPlayer(v) and not IsPedFatallyInjured(v) then
                        if ((crime == 'possession' or crime == 'fight') and IsPedFacingPed(v, playerPed, 15.0)) or crime == 'firing' then
                            TriggerEvent('pw_chat:client:DoPoliceDispatch', code, message, (crime == 'fight' and { ['victim'] = playerData.sex, ['attacker'] = data.attackerSex } or playerData.sex ))
                            SetOnReported(crime, data)
                            break
                        end
                    end
                end
            end
        end
    end
end

function SetOnReported(crime, data)
    if crime == 'fight' then
        recentlyReported[crime].attacker = data.attacker
        recentlyReported[crime].victim = data.victim
        TriggerServerEvent('pw_police:server:markAsReported', 'fight', data)
    else
        recentlyReported[crime] = true
    end
    Citizen.CreateThread(function()
        Citizen.Wait(30000)
        if crime == 'fight' then
            recentlyReported[crime].attacker = 0
            recentlyReported[crime].victim = 0
            TriggerServerEvent('pw_police:server:markAsNotReported', 'fight', data)
        else
            recentlyReported[crime] = false
        end
    end)
end

RegisterNetEvent('pw_police:client:markAsReported')
AddEventHandler('pw_police:client:markAsReported', function(crime, data)
    recentlyReported[crime].attacker = data.attacker
    recentlyReported[crime].victim = data.victim
end)

RegisterNetEvent('pw_police:client:markAsNotReported')
AddEventHandler('pw_police:client:markAsNotReported', function(crime, data)
    recentlyReported[crime].attacker = 0
    recentlyReported[crime].victim = 0
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if characterLoaded and playerData then
            if playerData.job.job ~= 'police' or (playerData.job.job == 'police' and not playerData.job.duty) then
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local inZone = false
                for k,v in pairs(Config.AllowedShootingZones) do
                    local dist = #(playerCoords - vector3(v.x, v.y, v.z))
                    if dist <= v.radius then
                        inZone = true
                        break
                    end
                end
                canShoot = inZone
            else
                canShoot = true
            end
        end
    end
end)

---- Physical fights
AddEventHandler('DamageEvents:EntityDamaged', function(entity, attacker, weaponHash, isMelee)
    if isMelee then
        local playerPed = PlayerPedId()
        if entity == playerPed and entity ~= attacker and recentlyReported['fight'].attacker == 0 and recentlyReported['fight'].attacker == 0 and recentlyReported['fight'].victim == 0 and recentlyReported['fight'].victim == 0 then
            if IsPedAPlayer(entity) and IsPedAPlayer(attacker) then
                math.randomseed(GetGameTimer())
                local chance = math.random(1,100)
                if chance <= Config.AlertChance then
                    local playerCoords = GetEntityCoords(playerPed)
                    local closestPeds = PW.Game.GetClosestPedsInArea(playerCoords, Config.ClosePedsRadius)
                    if closestPeds ~= nil and closestPeds[1] then
                        for k,v in pairs(closestPeds) do
                            if not IsPedAPlayer(v) and not IsPedFatallyInjured(v) then
                                local attackerSex
                                local victimSex = playerData.sex
                                local attackerNet = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker))
                                PW.TriggerServerCallback('pw_police:server:getSuspectSex', function(sex)
                                    attackerSex = sex
                                end, attackerNet)
                                repeat Wait(0) until attackerSex ~= nil
                                NPCReport('fight', { ['attacker'] = attackerNet, ['attackerSex'] = attackerSex, ['victim'] = GetPlayerServerId(PlayerId()) })
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('pw_police:displayCrimeBlip')
AddEventHandler('pw_police:displayCrimeBlip', function(code, coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.Blips.crime.type)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, Config.Blips.crime.scale)
    SetBlipColour (blip, Config.Blips.crime.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("[" .. code .. "]")
    EndTextCommandSetBlipName(blip)
    RemoveCrimeBlip(blip)
end)

function RemoveCrimeBlip(blip)
    Citizen.CreateThread(function()
        Citizen.Wait(Config.CrimeBlipDisplay * 1000 --[[ * 60 for minutes ]])
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end
--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if characterLoaded and playerData then
            if playerData.job.job == 'police' and playerData.job.duty then
                if IsControlPressed(0, 21) and IsControlJustPressed(0, 175) then
                    escortPlayer()
                end

                if IsControlPressed(0, 21) and IsControlJustPressed(0, 174) then
                    putInVehicle()
                end

                if IsControlPressed(0, 21) and IsControlJustPressed(0, 172) then
                    arrestPlayer('soft')
                end

                if IsControlPressed(0, 21) and IsControlJustPressed(0, 173) then
                    arrestPlayer('hard')
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        if characterLoaded and playerData then
            if inCustody and dragged then
                local playerPed = PlayerPedId()
                local dead = IsPedDeadOrDying(playerPed, true)
                if dead then
                    dragged = false
                    inCustody = false
                    TriggerServerEvent('pw_police:server:playerDead', GetPlayerServerId(PlayerId()))
                    DetachEntity(playerPed, true, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if characterLoaded and playerData then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            for k,v in pairs(Config.Stations) do
                for j,b in pairs(v.markers) do
                    if b.public or (not b.public and playerData.job.job == 'police' and playerData.job.workplace == k and (not b.dutyNeeded or (b.dutyNeeded and playerData.job.duty))) then
                        local dist = #(pedCoords - vector3(b.coords.x, b.coords.y, b.coords.z))
                        if dist < b.drawDistance then
                            if not showing then
                                showing = k..j
                                DrawText(j, showing, k)
                            end
                        elseif showing == k..j then
                            showing = false
                            TriggerEvent('pw_drawtext:hideNotification')
                            if j == "evidenceStorage" or "evidenceTrash" then
                                TriggerEvent('pw_inventory:client:removeSecondary', (j == "evidenceStorage" and "evidence" or "evidenceTrash"))
                            end
                        end
                    elseif showing == k..j then
                        showing = false
                        TriggerEvent('pw_drawtext:hideNotification')
                        if j == "evidenceStorage" or "evidenceTrash" then
                            TriggerEvent('pw_inventory:client:removeSecondary', (j == "evidenceStorage" and "evidence" or "evidenceTrash"))
                        end
                    end
                end
            end
        end
    end
end)

function LoadAnimDict(dictname)
    if not HasAnimDictLoaded(dictname) then
        RequestAnimDict(dictname) 
        while not HasAnimDictLoaded(dictname) do 
            Citizen.Wait(1)
        end
    end
end