PW = nil
characterLoaded, playerData = false, nil
local beenPutInCar, isCarry, lifed, showing = false, false, false, false
local GLOBAL_PED, GLOBAL_COORDS

Citizen.CreateThread(function()
    while PW == nil do
        TriggerEvent('pw:getSharedObject', function(obj) PW = obj end)
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('pw:characterLoaded')
AddEventHandler('pw:characterLoaded', function(data)
    playerData = data
    characterLoaded = true
    GLOBAL_PED = PlayerPedId()
    GLOBAL_COORDS = GetEntityCoords(GLOBAL_PED)
    TriggerServerEvent('pw_ems:server:getHealth')
end)

RegisterNetEvent('pw:characterUnLoaded')
AddEventHandler('pw:characterUnLoaded', function()
    UpdateHealth()
    characterLoaded = false
    playerData = nil    
end)

RegisterNetEvent('pw:setJob')
AddEventHandler('pw:setJob', function(data)
    if playerData ~= nil then
        playerData.job = data
    end    
end)

RegisterNetEvent('pw:toggleDuty')
AddEventHandler('pw:toggleDuty', function(toggle)
    if playerData then
        playerData.job.duty = toggle
    end
end)

function UpdateHealth()
    local ped = PlayerPedId()
    local curHealth = GetEntityHealth(ped)

    if curHealth <= 100 then
        curHealth = 99
    end
    
    TriggerServerEvent('pw_ems:server:updateHealth', curHealth)
end

RegisterNetEvent('pw_ems:loadHealth')
AddEventHandler('pw_ems:loadHealth', function(health)
    local ped = PlayerPedId()
    local setHealth = health
    
    if setHealth == nil then 
        setHealth = 200
    end
    if setHealth > 100 and setHealth <= 200 then
        SetEntityHealth(ped, setHealth)
    elseif setHealth <= 100 then
        TriggerEvent('pw_skeleton:client:BedRespawn')
    end
end)

function displayMarkerText(markerId, var, hospital)
    local title, message, icon
    if markerId == "dutySignon" then
        title = "Work Duty"
        message = "<b>[ <span class='text-danger'>E</span> ] Sign <span class ='text-" .. (playerData.job.duty and "danger'>OFF" or "success'>ON") .. "</span> Duty</b>"
        icon = "fad fa-notes-medical"
    elseif markerId == "changingRoom" then
        title = "Changing Room"
        message = "<b>[ <span class='text-danger'>E</span> ] Change <span class ='text-primary'>OUTFIT</span></b>"
        icon = "fad fa-user-md"
    elseif markerId == "vehicleGarage" then
        title = "Vehicle Garage"
        message = "<b>[ <span class='text-danger'>E</span> ] <span class ='text-primary'>VEHICLE GARAGE</span></b>"
        icon = "fad fa-ambulance"
    elseif markerId == "helipadGarage" then
        title = "Helipad"
        message = "<b>[ <span class='text-danger'>E</span> ] <span class ='text-primary'>AIRCRAFT GARAGE</span></b>"
        icon = "fad fa-helicopter"
    end

    if title and message and icon then
        TriggerEvent('pw_drawtext:showNotification', { title = title, message = "<span style='font-size:18px'>" .. message .. "</span>", icon = icon })
    end

    Citizen.CreateThread(function()
        while showing == var do
            Citizen.Wait(1)
            if IsControlJustPressed(0, 38) then
                if markerId == 'dutySignon' then
                    TriggerServerEvent('pw_ems:toggleSignOn')
                elseif markerId == 'changingRoom' then
                    
                elseif markerId == 'vehicleGarage' then
                    OpenGarage(hospital)
                elseif markerId == 'helipadGarage' then
                    local foundHeli = CheckHeli(hospital)
                    if foundHeli and foundHeli ~= 0 then
                        ParkHeli(foundHeli, hospital)
                    elseif foundHeli == 0 then
                        exports.pw_notify:SendAlert('error', 'There\'s a vehicle in the way that\'s not an aircraft', 5000)
                    else
                        HelipadMenu(hospital)
                    end
                end
            end
        end
    end)
end

function HelipadMenu(hospital)
    local menu = {}

    for k,v in pairs(Config.Hospitals[hospital].helipadGarage.availableVehicles) do
        if playerData.job.grade_level >= k then
            for i = 1, #v do
                table.insert(menu, { ['label'] = GetVehNameByModel(v[i]), ['action'] = 'pw_ems:client:spawnHeli', ['value'] = { ['model'] = v[i], ['hospital'] = hospital }, ['triggertype'] = 'client', ['color'] = 'primary' })
            end
        end
    end

    TriggerEvent('pw_interact:generateMenu', menu, "EMS Helipad")
end

function ParkHeli(heli, hospital)
    local found = false
    
    for k,v in pairs(Config.Hospitals[hospital].helipadGarage.availableVehicles) do
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
        exports.pw_notify:SendAlert('error', 'This vehicle doesn\'t belong to this Hospital, you can\'t park it here.', 5000)
    end
end

function CheckHeli(hospital)
    local playerPed = PlayerPedId()
    local allowedClass = { 15, 16, 17, 18, 19 }
    local rayHandle = StartShapeTestBox(Config.Hospitals[hospital].helipadGarage.spawnCoords.x, Config.Hospitals[hospital].helipadGarage.spawnCoords.y, Config.Hospitals[hospital].helipadGarage.spawnCoords.z, 15.0, 15.0, 8.0, 0.0, 0.0, 0.0, true, 2, 0)
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

RegisterNetEvent('pw_ems:client:spawnHeli')
AddEventHandler('pw_ems:client:spawnHeli', function(data)
    local coords = Config.Hospitals[data.hospital].helipadGarage.spawnCoords
    PW.Game.SpawnOwnedVehicle(data.model, coords, coords.h, function(spawnedVeh)
        local props = PW.Game.GetVehicleProperties(spawnedVeh)
        PW.TriggerServerCallback('pw_vehicleshop:server:registerPotentialVin', function(vin)
            TriggerServerEvent('pw_keys:issueKey', "Vehicle", vin, false, true)
        end, props, spawnedVeh)
    end)
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

RegisterNetEvent('pw_ems:client:spawnVeh')
AddEventHandler('pw_ems:client:spawnVeh', function(data)
    local coords = Config.Hospitals[data.hospital].vehicleGarage.spawnCoords

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

function OpenGarage(hospital)
    if IsPedInAnyVehicle(GLOBAL_PED, true) then
        ParkVehicle(hospital)
    else
        local menu = {}

        for k,v in pairs(Config.Hospitals[hospital].vehicleGarage.availableVehicles) do
            if playerData.job.grade_level >= k then
                for i = 1, #v do
                    table.insert(menu, { ['label'] = GetVehNameByModel(v[i]), ['action'] = 'pw_ems:client:spawnVeh', ['value'] = { ['model'] = v[i], ['hospital'] = hospital }, ['triggertype'] = 'client', ['color'] = 'primary' })
                end
            end
        end

        TriggerEvent('pw_interact:generateMenu', menu, "EMS Garage")
    end
end

function ParkVehicle(hospital)
    local found = false
    local pedVeh = GetVehiclePedIsIn(GLOBAL_PED)
    if GetPedInVehicleSeat(pedVeh, -1) == GLOBAL_PED then
        for k,v in pairs(Config.Hospitals[hospital].vehicleGarage.availableVehicles) do
            for i = 1, #v do
                if GetHashKey(v[i]) == GetEntityModel(pedVeh) then
                    found = true
                    break
                end
            end
        end

        if found then
            local vin = PW.Vehicles.GetVinNumber(PW.Game.GetVehicleProperties(pedVeh).plate)
            TriggerServerEvent('pw_keys:revokeKeys', 'Vehicle', vin, true, nil)
            SetEntityAsMissionEntity(pedVeh, true, true)
            DeleteEntity(pedVeh)
        else
            exports.pw_notify:SendAlert('error', 'This vehicle doesn\'t belong to this Hospital, you can\'t park it here.', 5000)
        end
    end
end

function getHospitals()
    return Config.Hospitals
end

exports('getHospitals', function()
    return getHospitals()
end)

RegisterNetEvent('pw_ems:putPedInVehicle')
AddEventHandler('pw_ems:putPedInVehicle', function()
    if beenPutInCar then
        TriggerEvent('pw_ems:OutVehicle')
        beenPutInCar = false
    else
        TriggerEvent('pw_ems:putInVehicle')
        beenPutInCar = true
    end
end)

RegisterNetEvent('pw_ems:putInVehicle')
AddEventHandler('pw_ems:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
                TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('pw_ems:OutVehicle')
AddEventHandler('pw_ems:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function putInVehicle()
    local playerPed = PlayerPedId()
    if PW ~= nil then
        local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.0 and closestDistance >= 0.01 then
            TriggerServerEvent('pw_ems:putInVehicle', GetPlayerServerId(closestPlayer))
        end
    end
end

Citizen.CreateThread(function()
    for i = 1, #Config.Hospitals do
        local xPos = Config.Hospitals[i].location.coords.x
        local yPos = Config.Hospitals[i].location.coords.y
        local zPos = Config.Hospitals[i].location.coords.z
        local blip = AddBlipForCoord(xPos, yPos, zPos)
        SetBlipSprite(blip, Config.Blip.blipType)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, Config.Blip.blipScale)
        SetBlipColour (blip, Config.Blip.blipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.Blip.blipName))
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if characterLoaded then
            GLOBAL_PED = PlayerPedId()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if characterLoaded and GLOBAL_PED then
            GLOBAL_COORDS = GetEntityCoords(GLOBAL_PED)
        end
    end
end)

-- Hospital Job Markers
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if characterLoaded and playerData then
            for i = 1, #Config.Hospitals do
                for k,v in pairs(Config.Hospitals[i]) do
                    if v.marker and ((v.duty and playerData.job.duty and not v.public and playerData.job.job == "ems" and i == playerData.job.workplace) or (not v.duty and not v.public and playerData.job.job == "ems" and i == playerData.job.workplace) or v.public) then
                        local dist = #(GLOBAL_COORDS - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if dist < 2.0 or (dist < 7.0 and k == 'vehicleGarage') then
                            if not showing then
                                showing = k..i
                                displayMarkerText(k, showing, i)
                            end
                        elseif showing == k..i then
                            showing = false
                            TriggerEvent('pw_drawtext:hideNotification')
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('pw_ems:getClosestPickUp')
AddEventHandler('pw_ems:getClosestPickUp', function()
    local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()

    TriggerServerEvent('pw_ems:liftup', GetPlayerServerId(closestPlayer))
    Citizen.Wait(5000)

    local dict = "anim@heists@box_carry@"
    LoadAnimationDictionary(dict)

    if closestDistance ~= -1 and closestDistance <= 3.0 and closestPlayer ~= -1 then
        local targetPed = GetPlayerPed(GetPlayerFromServerId(closestPlayer))
        TriggerServerEvent('pw_ems:lifter', GetPlayerServerId(closestPlayer))		
        TaskPlayAnim(GetPlayerPed(-1), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        isCarry = true
    else
        exports['pw_notify']:SendAlert('error', 'No one is nearby')
    end
end)

RegisterNetEvent('pw_ems:uplift')
AddEventHandler('pw_ems:uplift', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local dict = "amb@code_human_in_car_idles@low@ps@"
	
	if isCarry == false then
		LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
		TaskPlayAnim(playerPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
        
        isCarry = true
		Citizen.CreateThread(function()
			while true do
                if characterLoaded then
                    if isCarry then
                        AttachEntityToEntity(playerPed, targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
                    end
                end
                Citizen.Wait(1)
			end
        end)
        lifted = true
	else
		DetachEntity(GetPlayerPed(-1), true, false)
		ClearPedTasksImmediately(targetPed)
		ClearPedTasksImmediately(playerPed)
		lifted = false
		isCarry = false
	end
end)

function LoadAnimationDictionary(animationD)
    while(not HasAnimDictLoaded(animationD)) do
        RequestAnimDict(animationD)
        Citizen.Wait(1)
    end
end

Citizen.CreateThread(function()
	while true do
        if characterLoaded then
            if lifted then
                DisableControlAction(1, 73, true)
                DisableControlAction(1, 24, true)
                DisableControlAction(1, 25, true)
                DisableControlAction(1, 21, true)
            else
                EnableControlAction(1, 73, true)
                EnableControlAction(1, 24, true)
                EnableControlAction(1, 25, true)
                EnableControlAction(1, 21, true)
            end
        end
        Citizen.Wait(1)
	end
end)

RegisterNetEvent('pw_ems:revive')
AddEventHandler('pw_ems:revive', function()
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	
	local formattedCoords = {
		x = coords.x,
		y = coords.y,
		z = coords.z
	}

	RespawnPed(playerPed, formattedCoords, 0.0)
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
    ClearPedBloodDamage(ped)
    TriggerEvent('pw_skeleton:client:RemoveBleed')
    TriggerEvent('pw_skeleton:client:ResetLimbs')
    TriggerEvent('pw_needs:client:resetStats')
end

RegisterNetEvent('pw_ems:getRevived')
AddEventHandler('pw_ems:getRevived', function()
    exports["pw_notify"]:SendAlert('info', 'A paramedic is performing CPR maneuver on you')
end)

RegisterNetEvent('pw_ems:giveCPR')
AddEventHandler('pw_ems:giveCPR', function(target)
    exports['pw_progbar']:Progress({
        name = "hospital_action",
        duration = 15000,
        label = "Performing CPR maneuver",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = { 
            animDict = 'mini@cpr@char_a@cpr_str',
            anim = 'cpr_pumpchest',
            flags = 01,
        },
    }, function(status)
        if not status then
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('pw_ems:reviveFinal', target)
        end
    end)
    
end)

RegisterNetEvent('pw_ems:getClosestRevive')
AddEventHandler('pw_ems:getClosestRevive', function(reviveType)
    if reviveType == "close" then
        local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()

        if closestDistance < 3.0 and IsPedDeadOrDying(closestPlayer) then
            TriggerServerEvent('pw_ems:reviveS', GetPlayerServerId(closestPlayer))
        else
            exports['pw_notify']:SendAlert('error', 'No one is nearby')
        end
    elseif type(tonumber(reviveType)) == "number" then
        TriggerServerEvent('pw_ems:reviveS', reviveType)
    elseif reviveType == nil then
        TriggerEvent('pw_ems:revive')
    else
        exports['pw_notify']:SendAlert('error', 'An error has occurred')
    end
end)

RegisterNetEvent('pw_ems:heal')
AddEventHandler('pw_ems:heal', function()
    local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

    SetEntityHealth(playerPed, maxHealth)
    TriggerEvent('pw_skeleton:client:RemoveBleed')
    TriggerEvent('pw_skeleton:client:ResetLimbs')
end)

RegisterNetEvent('pw_ems:giveHeal')
AddEventHandler('pw_ems:giveHeal', function(target)
    local playerPed = PlayerPedId()

    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    exports['pw_progbar']:Progress({
        name = "hospital_action",
        duration = 10500,
        label = "Healing",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
            ClearPedTasks(playerPed)
            TriggerServerEvent('pw_ems:healFinal', target)
        end
    end)
        
    
end)

RegisterNetEvent('pw_ems:getHealed')
AddEventHandler('pw_ems:getHealed', function()
    exports["pw_notify"]:SendAlert('info', 'You are being treated')
end)

RegisterNetEvent('pw_ems:getClosestHeal')
AddEventHandler('pw_ems:getClosestHeal', function(healType)
    if healType == "close" then
        
        local closestPlayer, closestDistance = PW.Game.GetClosestPlayer()
        
        if closestDistance < 3.0 and closestPlayer > 0 then
            TriggerServerEvent('pw_ems:healS', GetPlayerServerId(closestPlayer))
        else
            exports['pw_notify']:SendAlert('error', 'No one is nearby')
        end
    elseif type(tonumber(healType)) == "number" then
        TriggerServerEvent('pw_ems:healS', healType)
    elseif healType == nil then
        TriggerEvent('pw_ems:heal')
    else
        exports['pw_notify']:SendAlert('error', 'An error has occurred')
    end
end)

Citizen.CreateThread(function()
    while true do
        if characterLoaded then
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        end
        Citizen.Wait(1)
    end
end)