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
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/RBXScripts-Drive/main/girgmnijnrw09LIB.lua"))()
local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/functions.lua"))()

functions:Initialize()

if multiplayer and typeof(multiplayer) == "table" then
	warn("[TDS-PLAYER]: Multiplayer module initialized!")
end

if webhooks and typeof(webhooks) == "table" then
	warn("[TDS-PLAYER]: Webhooks module initialized!")
end

if library and typeof(library) == "table" then
	warn("[TDS-PLAYER]: Library module initialized!")
end

if functions and typeof(functions) == "table" then
	warn("[TDS-PLAYER]: Functions module initialized!")
end

if functions:CheckWebhook() == "true" then
	webhooks:SendWebhook(getgenv().Settings.Logs, {
		["username"] = "TDS-Player",
		["content"] = tostring(game.Players.LocalPlayer.Name).." has loaded TDS-Player"
	})
end

if getgenv().Settings.Multiplayer.Enabled == true then
	
	local PlrData = functions:GetOnlinePlayers()
	
	print(PlrData["Players"].." online; "..PlrData["MultiplayerPlayers"].." multiplayer players online")
	if functions:CheckWebhook() == "true" then
		webhooks:SendWebhook(getgenv().Settings.Logs, {
			["username"] = "TDS-Player",
			["content"] = "Online: "..PlrData["Players"].."; Multiplayer Players: "..PlrData["MultiplayerPlayers"]
		})
	end
	
else
	
	spawn(function()
		local v = 0
		repeat
			warn("[TDS-PLAYER]: Script is not finished!")
			print("[TDS-PLAYER]: Script is not finished!")
			v += 1
			wait(0.05)
		until v >= 25
	end)
	
end
