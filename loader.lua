if getgenv().Settings == nil then return warn("[TDS-PLAYER]: Settings not found!") end

warn([[
  _____ ___  ___     ___ _                   
 |_   _|   \/ __|___| _ \ |__ _ _  _ ___ _ _ 
   | | | |) \__ \___|  _/ / _` | || / -_) '_|
   |_| |___/|___/   |_| |_\__,_|\_, \___|_|  
                                |__/ ]])
warn("[TDS-PLAYER]: Initializing..")

local notice = "Go to https://github.com/RetiiAyo/ to learn more"
local multiplayer = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/multiplayer.lua"))()
local webhooks = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/webhooks.lua"))()

if multiplayer and typeof(multiplayer) == "table" then
	warn("[TDS-PLAYER]: Multiplayer module initialized!")
end

if webhooks and typeof(webhooks) == "table" then
	warn("[TDS-PLAYER]: Webhooks module initialized!")
end

if getgenv().Settings.Multiplayer.Enabled == true then
	
	local PlrsOnline = multiplayer:CheckForPlayers(getgenv().Settings.Multiplayer.Players)
	
	warn("[TDS-PLAYER]: Game Players: "..tostring(#game:GetService("Players"):GetPlayers()))
	warn("[TDS-PLAYER]: Multiplayer Players: "..tostring(#PlrsOnline))
	
else
	
	spawn(function()
		local v = 0
		repeat
			warn("[TDS-PLAYER]: Script is not finished!")
			v += 1
			wait(0.05)
		until v >= 50
	end)
	
end
