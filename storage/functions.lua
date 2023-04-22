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

return module
