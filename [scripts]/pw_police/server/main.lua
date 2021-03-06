PW = nil
local currentCustody = {}

TriggerEvent('pw:getSharedObject', function(obj)
    PW = obj
end)

MySQL.ready(function ()
    MySQL.Async.execute("DELETE FROM `stored_items` WHERE `inventoryType` = @type", {['@type'] = 16}, function(changed)
        if changed > 0 then
            print(' ^1[PixelWorld Police] ^5- We have deleted ^4'..changed..'^5 items from the Evidence Trash Bins^7')
        end
    end)
end)

RegisterServerEvent('pw_police:server:arrestCitizen')
AddEventHandler('pw_police:server:arrestCitizen', function(playerId, playerHeading, playerCoords, playerLocation, cuffType)
    local _src = source

    if playerId ~= _src then
        local _cop = exports.pw_base:Source(_src)
        local _target = exports.pw_base:Source(playerId)
        local isArrested = IsInCustody(playerId)
        if isArrested then
            if currentCustody[isArrested].type == cuffType then
                local returnJob = currentCustody[isArrested].job

                _target:Job().setJob(returnJob.job, returnJob.grade, returnJob.workplace)
                currentCustody[isArrested] = nil
                TriggerClientEvent('pw_police:client:uncuffPlayer', _src)
                TriggerClientEvent('pw_police:client:getUncuffed', playerId, playerHeading, playerCoords, playerLocation)
            else
                TriggerClientEvent('pw_police:client:cuffPlayer', _src, cuffType)
                TriggerClientEvent('pw_police:client:getCuffed', playerId, playerHeading, playerCoords, playerLocation, cuffType)
                currentCustody[isArrested].type = cuffType
            end
        else
            table.insert(currentCustody, { ['id'] = playerId, ['type'] = cuffType, ['job'] = _target:Job().getJob() })
            _target:Job().removeJob()
            TriggerClientEvent('pw_police:client:cuffPlayer', _src, cuffType)
            TriggerClientEvent('pw_police:client:getCuffed', playerId, playerHeading, playerCoords, playerLocation, cuffType)
        end

        TriggerClientEvent('pw_police:client:getCustody', -1, currentCustody)
    end    
end)

function IsInCustody(id)
    for k,v in pairs(currentCustody) do
        if v.id == id then
            return k
        end
    end
    return false
end

RegisterServerEvent('pw_police:server:playerDead')
AddEventHandler('pw_police:server:playerDead', function(id)
    local isArrested = IsInCustody(id)
    if isArrested then
        currentCustody[isArrested] = nil
        TriggerClientEvent('pw_police:client:getCustody', -1, currentCustody)
        TriggerClientEvent('pw_police:client:checkDragging', -1, id)
    end
end)

RegisterServerEvent('pw_police:server:toggleDuty')
AddEventHandler('pw_police:server:toggleDuty', function()
    local _src = source
    local _char = exports.pw_base:Source(_src)
    
    _char:Job().toggleDuty()
end)

RegisterServerEvent('pw_police:server:dragPlayer')
AddEventHandler('pw_police:server:dragPlayer', function(target, force)
    local _src = source
    TriggerClientEvent('pw_police:client:dragPlayer', target, _src, force)
end)

RegisterServerEvent('pw_police:server:draggingPlayer')
AddEventHandler('pw_police:server:draggingPlayer', function(cop, state)
    local _src = source
    TriggerClientEvent('pw_police:client:draggingPlayer', cop, state, _src)
end)

RegisterServerEvent('pw_police:server:sendToCar')
AddEventHandler('pw_police:server:sendToCar', function(target, veh, seat)
    TriggerClientEvent('pw_police:client:sendToCar', target, veh, seat)
end)

RegisterServerEvent('pw_police:server:leaveCar')
AddEventHandler('pw_police:server:leaveCar', function(target, veh)
    TriggerClientEvent('pw_police:client:leaveCar', target, veh)
end)

RegisterServerEvent('pw_police:server:createBlip')
AddEventHandler('pw_police:server:createBlip', function(job)
    local _src = source
    TriggerClientEvent('pw_police:client:createBlip', -1, _src, job)
end)

RegisterServerEvent('pw_police:server:deleteBlip')
AddEventHandler('pw_police:server:deleteBlip', function()
    local _src = source
    TriggerClientEvent('pw_police:client:deleteBlip', -1, _src)
end)

RegisterServerEvent('pw_police:server:getDuties')
AddEventHandler('pw_police:server:getDuties', function()
    local _src = source
    local online = PW.CheckOnlineDuty('police')
    if online ~= nil then
        for k,v in pairs(online) do
            TriggerClientEvent('pw_police:client:createBlip', _src, v.source, 'police')
        end
    end
    online = PW.CheckOnlineDuty('ems')
    if online ~= nil then
        for k,v in pairs(online) do
            TriggerClientEvent('pw_police:client:createBlip', _src, v.source, 'ems')
        end
    end
end)

RegisterServerEvent('pw_police:server:createMyBlip')
AddEventHandler('pw_police:server:createMyBlip', function(target)
    local _src = source
end)

RegisterServerEvent('pw_police:server:markAsReported')
AddEventHandler('pw_police:server:markAsReported', function(crime, data)
    TriggerClientEvent('pw_police:client:markAsReported', data.attacker, crime, data)
end)

RegisterServerEvent('pw_police:server:markAsNotReported')
AddEventHandler('pw_police:server:markAsNotReported', function(crime, data)
    TriggerClientEvent('pw_police:client:markAsNotReported', data.attacker, crime, data)
end)

exports.pw_chat:AddChatCommand('jail', function(source, args, rawCommand)
    local _src = source
    local target = tonumber(args[1])
    local time = tonumber(args[2])
    if target ~= nil and time ~= nil then
        TriggerClientEvent('pw_police:client:sendToPrison', target, time, _src)
    end
end, {
    help = "Jail a player, You must be at a police station.",
    params = {{
            name = "ServerID",
            help = "The ID of the player to send to jail"
        },
        {
            name = "Months",
            help = "The number of months to send the person to jail for."
        }
    }
}, -1, { "police", "judge" })

exports.pw_chat:AddChatCommand('mdt', function(source, args, rawCommand)
    local _src = source
    TriggerClientEvent('pw_police:client:openMdt', _src)
end, {
    help = "Open Police MDT",
}, -1, { "police", "judge" })

exports.pw_chat:AddChatCommand('impound', function(source, args, rawCommand)
    TriggerClientEvent('pw_garage:client:impoundVehicle', source)
end, {
    help = 'Impound nearest vehicle',
    params = {}
}, -1, { 'police' })

PW.RegisterServerCallback('pw_police:server:sendCustody', function(source, cb)
    cb(currentCustody)
end)

PW.RegisterServerCallback('pw_police:server:getSuspectSex', function(source, cb, id)
    local _src = source
    if id then
        local _suspect = exports.pw_base:Source(id)
        if _suspect then
            local sex = _suspect:Character().getSex()
            cb(sex)
        end
    else
        cb("bot")
    end
end)

