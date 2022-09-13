local QBCore = exports["qb-core"]:GetCoreObject()
--Взима job-a на играча
AddEventHandler('onResourceStart', function(resource) 
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = QBCore.Functions.GetPlayerData().job
        isLoggedIn = true
    end
end)
--Взима пола на играча
local function GetPedGender()
    local gender = "Male"
    if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then gender = "Female" end
    return gender
end
--Взима локацията на играча
local function GetDirectionText(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return 'На Север'
    elseif (heading >= 45 and heading < 135) then
        return 'На Юг'
    elseif (heading >= 135 and heading < 225) then
        return 'На Изток'
    elseif (heading >= 225 and heading < 315) then
        return 'На Запад'
    end
end
--Взима Улицата И Зоната на играча
function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end
--Взима alert-овете, които винаги се пускат
Citizen.CreateThread(function()
    local cooldown = 0
    local isBusy = false
	while true do
		Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed) and Config["AutoAlerts"]["CarJacking"] then
            Citizen.Wait(3000)
			local vehicle = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
            local vehicleColor1, vehicleColor2 = GetVehicleColours(vehicle)
            local firstcolor = Config.Colours[tostring(vehicleColor1)]
            TriggerEvent("qb-dispatch:carjacking", {
                model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
                plate = GetVehicleNumberPlateText(vehicle),
                firstColor = firstcolor,
                heading = GetEntityHeading(vehicle)
            })
        elseif IsPedShooting(playerPed) and (cooldown == 0 or cooldown - GetGameTimer() < 0) and not isBusy and Config["AutoAlerts"]["GunshotAlert"] then
            isBusy = true
            if IsPedCurrentWeaponSilenced(playerPed) then
                cooldown = GetGameTimer() + math.random(25000, 30000)
                TriggerEvent("qb-dispatch:gunshot")
            else
                cooldown = GetGameTimer() + math.random(15000, 20000)
                TriggerEvent("qb-dispatch:gunshot")
            end
            isBusy = false
        end
    end
end)

RegisterNetEvent("qb-dispatch:createBlip", function(type, coords)
    if type == "bankrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 161)
        SetBlipColour(Blip, 46)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на банка в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "storerobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 52)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на магазин в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "houserobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 411)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на къща в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "jewelrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 434)
        SetBlipColour(Blip, 66)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на бижутерия в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "jailbreak" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 487)
        SetBlipColour(Blip, 4)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-98 Бягство от затвора в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "carjacking" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 488)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 1.5)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Кражба на автомобил в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "gunshot" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-60 Стрелба с оръжие')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end	
    elseif type == "officerdown" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-99 Полицей в беда')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "drugsell" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-51 Продажба на дрога')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "atmrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на ATM')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "casinorobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 679)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Алармите в казиното')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "civdown" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Наранен човек')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "artrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 269)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на галерия в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "humanerobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 499)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на Humane Labs')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "trainrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 795)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на влак в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "vanrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 67)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на Security Ван')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "undergroundrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 486)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на подземни тунели в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "drugboatrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 427)
        SetBlipColour(Blip, 26)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-31 Подозрителна дейност на лодка')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "unionrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 500)
        SetBlipColour(Blip, 60)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Обир на Union Depositary Robbering в прогрес')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end	
    elseif type == "911call" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 480)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 1.2)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Обаждане - 112')
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    end
end)

RegisterNetEvent("dispatch:clNotify", function(data, id)
    SendNUIMessage({
        update = "newCall",
        callID = id,
        data = data,
        timer = 5000
    })
end)
--Свален полицай
RegisterNetEvent("qb-dispatch:officerdown", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
	PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-99",
        fullname = PlayerData.charinfo.firstname,
        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "10-99 Свален Полицай"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:officerdown", currentPos)
end)

RegisterNetEvent("qb-dispatch:bankrobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        camId = camId,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на банка"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:bankrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:storerobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        camId = camId,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на магазин"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:storerobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:houserobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на къща"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:houserobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:jewelrobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        camId = camId,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на бижутерия"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:jewelrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:jailbreak", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-98",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Бягство от затвора"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:jailbreak", currentPos)
end)

RegisterNetEvent("qb-dispatch:carjacking", function(data)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        model = data.model,
        plate = data.plate,
        firstColor = data.firstColor,
        heading = GetDirectionText(data.heading),
        priority = 3,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Кражба на МПС"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:carjacking", currentPos)
end)

RegisterNetEvent("qb-dispatch:gunshot", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-60",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Изстрели"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:gunshot", currentPos)
end)

RegisterNetEvent("qb-dispatch:drugsell", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-51",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 3,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Възможна търговия с наркотици"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:drugsell", currentPos)
end)

RegisterNetEvent("qb-dispatch:atmrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на ATM"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:atmrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:civdown", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-60",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Наранен човек"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:civdown", currentPos)
end)

RegisterNetEvent("qb-dispatch:artrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на галерия"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:artrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:humanerobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на Humane Labs"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:humanerobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:trainrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на влак"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:trainrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:vanrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Обир на охранителен микробус"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:vanrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:undergroundrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Грабеж в подземни тунели"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:undergroundrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:drugboatrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-31",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Подозрителна дейност на лодка"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:drugboatrobbery", currentPos)
end)

RegisterNetEvent("qb-dispatch:unionrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Union Depository Обир"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:unionrobbery", currentPos)
end)


RegisterNetEvent("qb-dispatch:911call", function(message)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = GetPedGender()
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "911",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 2,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = message
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:911call", currentPos)
end)

RegisterNetEvent("qb-dispatch:casinorobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = IsPedMale(playerPed)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = gender,
        priority = 1,
        origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
        dispatchMessage = "Аларми в казиното"
    })
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent("qb-dispatch:casinorobbery", currentPos)
end)
