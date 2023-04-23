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

return module
