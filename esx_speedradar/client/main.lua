ESX = nil
local GUI = {}
GUI.Time = 0
local vitesse_flash = 0
local is_flashed = false
local PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--------------------------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function Info(text, loop)
 SetTextComponentFormat("STRING")
 AddTextComponentString(text)
 DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

function GetFlashMenu(idstation)

	 ESX.TriggerServerCallback('esx_peage:getFlash', function(allflash)
		local flashlist = allflash

		local elements = {
			head = {'N°', 'Plaque','Vitesse','Modèle','Action'},
			rows = {}
		}

		for i=1, #flashlist, 1 do

			table.insert(elements.rows, {
				data = flashlist[i],
				cols = {
					flashlist[i].id,
					flashlist[i].plate,
					flashlist[i].speed,
					flashlist[i].modele,
					' {{[Valider]|recup}} '
				}
			})
		end

			ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'flashlist',
			elements,
			function(data, menu)

				if data.value == 'recup' then
					TriggerServerEvent("esx_peage:delete_peage",data.data.id)
					menu.close()
				end
			end, function(data, menu)
				menu.close()
			end)
	end,idstation)
end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local PlayerPed = GetPlayerPed(-1)
		local coords_ped = GetEntityCoords(PlayerPed, true)
		  if((GetEntitySpeed(PlayerPed) * 3.6) > 155)then
					StartScreenEffect('RaceTurbo',  0,  false)
			else
				StopScreenEffect('RaceTurbo')
			end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

--SwitchShortMichaelIn
      local PlayerPed = GetPlayerPed(-1)
      local coords_ped = GetEntityCoords(PlayerPed, true)

  --    if(GetDistanceBetweenCoords(coords_ped,1376.419,669.30, 78.93, true) < 5 and PlayerData.job.name =='police')then
	if(GetDistanceBetweenCoords(coords_ped,1376.419,669.30, 78.93, true) < 5)then
         	Info("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'ordinateur")
          	DrawMarker(1, 1376.419,669.30, 78.93, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0,3.0, 1.0, 250, 100,100, 100, false, true, 2, false, false, false, false)
         if(IsControlPressed(1, 38))then
           GetFlashMenu("1")
         end
      end

      if(GetDistanceBetweenCoords(coords_ped, 1368.90, 671.22, 79.912, true) < 50 ) then
				if(not is_flashed)then
			        if((GetEntitySpeed(PlayerPed) * 3.6) > 90)then
			          if((GetEntitySpeed(PlayerPed) * 3.6) > vitesse_flash)then
			            vitesse_flash = (GetEntitySpeed(PlayerPed) * 3.6)
			          end
			          local vehicle_flash = GetVehiclePedIsIn(PlayerPed, true)
			          local vehicle_flash_plaque = GetVehicleNumberPlateText(vehicle_flash)
				  local vehicule_flash_modele = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle_flash))

			          is_flashed = true
			          TriggerServerEvent('esx_peage:flashed',vehicle_flash_plaque,vitesse_flash,vehicule_flash_modele,"1")
								StartScreenEffect('SwitchShortMichaelIn',  400,  false)
								end
					end
			        else

			          vitesse_flash = 0
			          is_flashed = false
      end
  end
end)
