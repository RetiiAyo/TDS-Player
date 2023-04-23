local module = {}
local multiplayer = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/multiplayer.lua"))()

function module:GetOnlinePlayers()
  local PlrsOnline = multiplayer:CheckForPlayers(getgenv().Settings.Multiplayer.Players)
  return {["Players"] = tostring(#game:GetService("Players"):GetPlayers()), ["MultiplayerPlayers"] = tostring(#PlrsOnline)}
end

function module:Initialize()
  if not isfolder("TDS-Player") then
    makefolder("TDS-Player")
    makefolder("TDS-Player/Saved")
    makefolder("TDS-Player/Logs")
  end
end

function module:CheckWebhook()
  if getgenv().Settings.Logs ~= "WEBHOOK HERE (NOT NEEDED)" then
    return true
  else
    return false
  end
end

function module:IsGame()
  if game.PlaceId == 5591597781 then
		return true
	else
		return false
	end
end

function module:CheckIfUpgrade(troop)
    local troopType = troop.Replicator:GetAttribute("Type")
    local upgradeNum = troop.Replicator:GetAttribute("Upgrade")
    local discountAmount = troop.Replicator:GetAttribute("DiscountBuff")
    local troopAssets = game:GetService("ReplicatedStorage").Assets.Troops[troopType]
    local nextUpgradePrice = require(troopAssets["Stats"]).Upgrades[upgradeNum+1].Cost
    if table.find(getgenv().GoldenPerks, troopType) then
        nextUpgradePrice = require(troopAssets["Stats_Golden"]).Upgrades[upgradeNum+1].Cost
    end
    if game:GetService("ReplicatedStorage").State.Difficulty.Value == "Hardcore" then
        nextUpgradePrice = math.floor(nextUpgradePrice*1.5)
    end
    if tonumber(discountAmount) > 0 then
        nextUpgradePrice = math.floor((nextUpgradePrice * (100-tonumber(discountAmount)))/100)
    end
    if cashRep:GetAttribute("Cash") >= nextUpgradePrice then
        return true
    else
        return false
    end
end

return module
