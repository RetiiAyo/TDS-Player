if getgenv().Settings == nil then return warn("[TDS-PLAYER]: Settings not found!") end

warn("(...)")

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

local RS = game:WaitForChild('ReplicatedStorage')
local RSRF = RS:WaitForChild("RemoteFunction")
local RSRE = RS:WaitForChild("RemoteEvent")

if not RSRF and RSRE then
	warn("[TDS-PLAYER]: RemoteEvent and RemoteFunction (TDS default) are missing. Please join TDS or report the bug to the Discord server")
	return
end

functions:Initialize()

local RVER = "1.4"
local Gperks = ""
getgenv().Towers = {}
getgenv().GoldenPerks = {}
getgenv().LoaderData = ""
getgenv().PlayerVar = "TDSPlr"

function getTroopTypeCheck(troop)
	return troop.Replicator:GetAttribute("Type")
end

function getTroopType(tr)
	local check = getTroopTypeCheck(tr)
	if check then
		return check
	else
		return "Unable to GET"
	end
end

local ChangeThen = 0
game:GetService("ReplicatedStorage").State.Timer.Time:GetPropertyChangedSignal("Value"):Connect(function()
	ChangeThen = ChangeThen + 1
	local ChangeNow = ChangeThen
	getgenv().WaveMillisecond = 0
	for i=1,9 do
		if ChangeThen > ChangeNow then
			break
		end
		task.wait(0.09)
		if ChangeThen > ChangeNow then
			break
		end
		getgenv().WaveMillisecond = getgenv().WaveMillisecond + 1
	end
end)

for TowerName, Tower in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
	if (Tower.Equipped) then
		table.insert(getgenv().Towers, TowerName)
		if (Tower.GoldenPerks) then
			table.insert(getgenv().GoldenPerks, TowerName)
		end
	end
end

for i = 1, 5 do
	if getgenv().Towers[i] == nil then
		getgenv().Towers[i] = "nil"
	end
end

if getgenv().GoldenPerks[1] then
	Gperks = Gperks.."getgenv().GoldenPerks = {"
	for i, v in pairs(getgenv().GoldenPerks) do
		Gperks = Gperks..'"'..v..'",'
	end
	Gperks = Gperks.."}\n"
end

if Gperks ~= "" then
	getgenv().LoaderData = getgenv().LoaderData.."-- TDS-Player "..RVER.."\n".."getgenv().File = '"..getgenv().FileName..".txt'\n"..Gperks.."local "..getgenv().PlayerVar.." = loadstring(game:HttpGet('https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/player.lua'))() \n"..getgenv().PlayerVar..":Loadout('"..getgenv().Towers[1].."', '"..getgenv().Towers[2].."', '"..getgenv().Towers[3].."', '"..getgenv().Towers[4].."', '"..getgenv().Towers[5].."') \n"..getgenv().PlayerVar..":Map('"..game:GetService("ReplicatedStorage").State.Map.Value.."', true, '"..game:GetService("ReplicatedStorage").State.Mode.Value.."')\n"
else
	getgenv().LoaderData = getgenv().LoaderData.."-- TDS-Player "..RVER.."\n".."getgenv().File = '"..getgenv().FileName..".txt'\n".."local "..getgenv().PlayerVar.." = loadstring(game:HttpGet('https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/player.lua'))() \n"..getgenv().PlayerVar..":Loadout('"..getgenv().Towers[1].."', '"..getgenv().Towers[2].."', '"..getgenv().Towers[3].."', '"..getgenv().Towers[4].."', '"..getgenv().Towers[5].."') \n"..getgenv().PlayerVar..":Map('"..game:GetService("ReplicatedStorage").State.Map.Value.."', true, '"..game:GetService("ReplicatedStorage").State.Mode.Value.."')\n"
end

local StateRep = nil

if functions:IsGame() then
	function getStateRep()
		for i, v in pairs(game:GetService("ReplicatedStorage").StateReplicators:GetChildren()) do
			if v:GetAttribute("TimeScale") then
				return v
			end
		end
	end
	
	repeat
		StateRep = getStateRep()
		task.wait()
	until StateRep
end

local CashRep = nil

repeat
	for i,v in pairs(game:GetService("ReplicatedStorage").StateReplicators:GetChildren()) do
		if v:GetAttribute("UserId") and v:GetAttribute("UserId") == game.Players.LocalPlayer.UserId then
			CashRep = v
		end
	end
	task.wait()
until CashRep

local function Convert(Seconds)
	return math.floor(Seconds / 60), Seconds % 60;
end;

local w = library:CreateWindow("Recorder")
w:Section("Last Record :")
w:Section("Recording")
local labelx
for i,v in pairs(game.CoreGui:GetDescendants()) do
	if v:IsA("TextLabel") and v.Text == "Recording" then
		labelx = v
	end
end
w:Section("")
w:Section("TimePassed")
spawn(function()
	local function TimeConverter(v)
		if v <= 9 then
			local conv = "0"..v
			return conv
		else
			return v
		end
	end
	local labelx = nil
	repeat
		for i,v in pairs(game.CoreGui:GetDescendants()) do
			if v:IsA("TextLabel") and v.Text == "TimePassed" then
				labelx = v
			end
		end
		task.wait()
	until labelx
	local startTime = os.time()
	while task.wait(0.1) do
		local t = os.time() - startTime
		local seconds = t % 60
		local minutes = math.floor(t / 60) % 60
		labelx.Text = "Time Passed : "..TimeConverter(minutes)..":"..TimeConverter(seconds)
		getgenv().TimePassed = "Time Passed : "..TimeConverter(minutes)..":"..TimeConverter(seconds)
	end
end)
warn("[TDS-PLAYER]: Recording..")
w:Section("")
w:Button("Sell All Farms", function()
	for i,v in pairs(game.Workspace.Towers:GetChildren()) do
		if getTroopType(v) == "Farm" and v.Owner.Value == game.Players.LocalPlayer.UserId then
			RSRF:InvokeServer("Troops","Sell",{["Troop"] = v,["Recorder"] = true})
			task.wait()
		end
	end
	local ReplicatedStorage = game:GetService("ReplicatedStorage");
	local State = ReplicatedStorage.State;
	local Wave = tonumber(StateRep:GetAttribute("Wave"));
	local Timer = State.Timer;
	local CurTime = Timer.Time.Value;
	local TM, TS = Convert(CurTime);
	getgenv().LoaderData = getgenv().LoaderData + getgenv().PlayerVar..":SellAllFarms( "..Wave..", "..TM..", "..TS.."."..getgenv().WaveMillisecond..")\n";
end)
w:Section("")
w:Button("Save", function()
	if not isfile("TDS-Player/Saved/"..getgenv().FileName..".txt") then
		writefile("TDS-Player/Saved/"..getgenv().FileName..".txt", "")
		appendfile("TDS-Player/Saved/"..getgenv().FileName..".txt", getgenv().LoaderData)
	end
end)

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

if functions:CheckWebhook() == true then
	webhooks:SendWebhook(getgenv().Settings.Logs, {
		["username"] = "TDS-Player",
		["content"] = tostring(game.Players.LocalPlayer.Name).." has loaded TDS-Player"
	})
end

local function passArgs(args, Msi, Wave, TM, TS, HalftTime, wasDid)
  if args[1] == "Troops" then
    
  end
  if args[1] == "Waves" and args[2] == "Skip" then
    getgenv().LoaderData = getgenv().LoaderData..getgenv().PlayerVar..":Skip("..Wave..", "..TM..", "..TS.."."..Msi..", "..tostring(HalftTime or "false")..")\n"
    labelx.Text = "Skipped wave"
  end
  if args[1] == "Difficulty" and args[2] == "Vote" then
    local Difficulty = args[3]
    local DiffTable = {["Easy"] = "Normal", ["Normal"] = "Molten", ["Insane"] = "Fallen"}
    if game:GetService("ReplicatedStorage").State.Mode.Value == "Survival" then
      getgenv().LoaderData = getgenv().LoaderData..getgenv().PlayerVar..":Mode('"..Difficulty.."') -- "..DiffTable[Difficulty].." is called "..Difficulty.."\n"
      labelx.Text = "Voted for difficulty"
    end
  end
end


