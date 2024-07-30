--
-- Core Functions
--

---@param src integer
---@param msg string
---@param type "success" | "warning" | "error"
function Framework.Server.Notify(src, msg, type)
  TriggerClientEvent("jg-advancedgarages:client:notify", src, msg, type, 5000)
end

---@param src integer
---@returns boolean
function Framework.Server.IsAdmin(src)
  return IsPlayerAceAllowed(tostring(src), "command") or false
end

function Framework.Server.PayIntoSocietyFund(jobName, money)
  local usingNewQBBanking = GetResourceState("qb-banking") == "started" and tonumber(string.sub(GetResourceMetadata("qb-banking", "version", 0), 1, 3)) >= 2

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    if usingNewQBBanking then
      exports["qb-banking"]:AddMoney(jobName, money)
    else
      exports["qb-management"]:AddMoney(jobName, money)
    end
  elseif Config.Framework == "ESX" then
    TriggerEvent("esx_society:getSociety", jobName, function(society)
      TriggerEvent("esx_addonaccount:getSharedAccount", society.account, function(account)
        account.addMoney(money)
      end)
    end)
  end
end

--
-- Player Functions
--

---@param src integer
function Framework.Server.GetPlayer(src)
  if Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayer(src)
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayer(src)
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerFromId(src)
  end
end

---@param src integer
function Framework.Server.GetPlayerInfo(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return {
      name = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.getName()
    }
  end
end

---@param src integer
---@return {name:string,label:string,grade:number} | false
function Framework.Server.GetPlayerJob(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    if not player.PlayerData then return false end

    return {
      name = player.PlayerData.job.name,
      label = player.PlayerData.job.label,
      grade = player.PlayerData.job.grade?.level or 0,
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade
    }
  end

  return false
end

---@param src integer
---@return {name:string,label:string,grade:number} | false
function Framework.Server.GetPlayerGang(src)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Server.GetPlayer(src)
    if not player then return false end

    return {
      name = player.PlayerData.gang.name,
      grade = player.PlayerData.gang.grade.level
    }
  elseif Config.Framework == "ESX" then
    error("ESX does not natively support gangs.");
  end

  return false
end

---@param src integer
function Framework.Server.GetPlayerIdentifier(src)
  local player = Framework.Server.GetPlayer(src)
  if not player then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.citizenid
  elseif Config.Framework == "ESX" then
    return player.getIdentifier()
  end
end

---@param identifier string
function Framework.Server.GetSrcFromIdentifier(identifier)
  if Config.Framework == "QBCore" then
    local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "Qbox" then
    local player = exports.qbx_core:GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player.PlayerData.source
  elseif Config.Framework == "ESX" then
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then return false end
    return xPlayer.source
  end
end

---@param src integer
---@param type "cash" | "bank" | "money"
function Framework.Server.GetPlayerBalance(src, type)
  local player = Framework.Server.GetPlayer(src)
  if not player then return 0 end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return player.PlayerData.money[type]
  elseif Config.Framework == "ESX" then
    if type == "cash" then type = "money" end

    for i, acc in pairs(player.getAccounts()) do
      if acc.name == type then
        return acc.money
      end
    end

    return 0
  end
end

---@param src integer
---@param amount number
---@param account "cash" | "bank" | "money"
---@return boolean success
function Framework.Server.PlayerRemoveMoney(src, amount, account)
  local player = Framework.Server.GetPlayer(src)
  account = account or "bank"

  if Framework.Server.GetPlayerBalance(src, account) < amount then
    Framework.Server.Notify(src, Locale.notEnoughMoneyError, "error")
    return false
  end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    player.Functions.RemoveMoney(account, round(amount, 0))
  elseif Config.Framework == "ESX" then
    if account == "cash" then account = "money" end
    player.removeAccountMoney(account, round(amount, 0))
  end

  return true
end

---@return {id:number,identifier:string,name:string}[] players
function Framework.Server.GetPlayers()
  local players = {}

  for _, playerId in ipairs(GetPlayers()) do
    players[#players+1] = {
      id = tonumber(playerId),
      identifier = Framework.Server.GetPlayerIdentifier(tonumber(playerId, 10)),
      name = Framework.Server.GetPlayerInfo(tonumber(playerId, 10))?.name
    }
  end
  
  return players
end

---@return table | false jobs
function Framework.Server.GetJobs()
  if Config.Framework == "QBCore" then
    return QBCore.Shared.Jobs
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetJobs()
  elseif Config.Framework == "ESX" then
    return ESX.GetJobs()
  end

  return false
end

---@return table | false gangs
function Framework.Server.GetGangs()
  if Config.Framework == "QBCore" then
    return QBCore.Shared.Gangs
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetGangs()
  elseif Config.Framework == "ESX" then
    error("ESX does not natively support gangs.");
  end

  return false
end

---@param vehicle integer
---@return string | false plate 
function Framework.Server.GetPlate(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  if not plate or plate == nil or plate == "" then return false end

  local trPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
  return trPlate
end

---@param vehicle table
---@return string | number | false model
function Framework.Server.GetModelColumn(vehicle)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return vehicle.vehicle or tonumber(vehicle.hash) or false
  elseif Config.Framework == "ESX" then
    if not vehicle or not vehicle.vehicle then return false end

    if type(vehicle.vehicle) == "string" then
      if not json.decode(vehicle.vehicle) then return false end
      return json.decode(vehicle.vehicle).model
    else
      return vehicle.vehicle.model
    end
  end

  return false
end

--
-- Brazzers-FakePlates
--

lib.callback.register("brazzers-fakeplates:getPlateFromFakePlate", function(_, fakeplate)
  local result = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE fakeplate = ?", {fakeplate})
  if result then return result end
  return false
end)

lib.callback.register("brazzers-fakeplates:getFakePlateFromPlate", function(_, plate)
  local result = MySQL.scalar.await("SELECT fakeplate FROM player_vehicles WHERE plate = ?", {plate})
  if result then return result end
  return false
end)

--
-- ti_fuel
--

RegisterNetEvent("jg-advancedgarages:server:save-ti-fuel-type", function(plate, type)
  MySQL.query.await("ALTER TABLE " .. Framework.VehiclesTable .. " ADD COLUMN IF NOT EXISTS `ti_fuel_type` VARCHAR(100) DEFAULT '';")
  MySQL.update.await("UPDATE " .. Framework.VehiclesTable .. " SET ti_fuel_type = ? WHERE plate = ?", {type, plate});
end)

lib.callback.register("jg-advancedgarages:server:get-ti-fuel-type", function(src, plate)
  MySQL.query.await("ALTER TABLE " .. Framework.VehiclesTable .. " ADD COLUMN IF NOT EXISTS `ti_fuel_type` VARCHAR(100) DEFAULT '';")
  return MySQL.scalar.await("SELECT ti_fuel_type FROM  " .. Framework.VehiclesTable .. " WHERE plate = ?", {plate}) or false
end)