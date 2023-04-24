local module = {}
local core = {}

local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/functions.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/RBXScripts-Drive/main/girgmnijnrw09LIB.lua"))()
local labelc

local RS = game:GetService("ReplicatedStorage")
local RSRE = RS:WaitForChild("RemoteEvent")
local RSRF = RS:WaitForChild("RemoteFunction")

function core:ForceChangeMaps()
  local L = game.ReplicatedStorage.RemoteFunction
  for a, c in pairs(game:GetService('Workspace').Elevators:GetChildren()) do
    local a = require(c.Settings).Type
    local b = c.State.Players
    if a == "Survival" and b.Value <= 0 then
      L:InvokeServer("Elevators", "Enter", c)
      wait(1)
      L:InvokeServer("Elevators", "Leave")
    end
  end
  wait(0.6)
  L:InvokeServer("Elevators", "Leave")
  wait(1)
  return true
end

function core:GetElevator(Map, Mode)
  for a, c in pairs(game:GetService("Workspace").Elevators:GetChildren()) do
    local b = require(c.Settings)
    local d = c.State
    local e = d.Players.Value
    local f = d.Map.Title.Value
		
    if tostring(f) == Map and e == 0 and b.Type == Mode then
      return { c, e, f }
    end
  end
end

function module:Setup()
  local w = library:CreateWindow("Player")
  w:Section("Current action :")
  w:Section("No action..")
  local labelx
  for i,v in pairs(game.CoreGui:GetDescendants()) do
	if v:IsA("TextLabel") and v.Text == "No action.." then
	  labelx = v
	  labelc = v
	end
  end
  
  return labelx
end

function module:Loadout(T1, T2, T3, T4, T5)
  if functions:IsGame() == true then
    print("game")
  else
    local labelx = module:Setup()
    
    local Towers = {}

    for TowerName, Tower in next, game.ReplicatedStorage.RemoteFunction:InvokeServer("Session", "Search", "Inventory.Troops") do
      print(TowerName)
      if (Tower.Equipped) then
          print("[EQUIPPED]: "..TowerName)
          table.insert(Towers, tostring(TowerName))
      end
      task.wait(0.01)
    end
    
    for i, v in pairs(Towers) do
      RSRF:InvokeServer(unpack({
          [1] = "Inventory",
          [2] = "Unequip",
          [3] = "Tower",
          [4] = tostring(v)
      }))
      labelx.Text = "Unequipped "..tostring(v)
      task.wait(0.3)
    end
    
    local index = { T1, T2, T3, T4, T5 }
    
    for i = 1, 5 do
      RSRF:InvokeServer(unpack({
          [1] = "Inventory",
          [2] = "Equip",
          [3] = "Tower",
          [4] = tostring(index[i])
      }))
      labelx.Text = "Equipped "..tostring(index[i])
    end
  end
end

function module:Map(Map, Bool, Mode)
  local JoinedElevator = false
  local Attempt = 0
  labelc.Text = "Waiting for map.."
  local Elevator = core:GetElevator(Map, Mode)
  repeat
      Elevator = core:GetElevator(Map, Mode)
      Attempt = Attempt + 1
      wait(1)
  until Elevator and typeof(Elevator) == "table" or Attempt >= 5
 
  if Elevator then
     local L = game.ReplicatedStorage.RemoteFunction
     L:InvokeServer("Elevators", "Enter", Elevator["c"])
     local sp = spawn(function()
       local oldPlrs = 0
       while wait() do
	 if oldPlrs ~= tonumber(Elevator["e"]) then
	   L:InvokeServer("Elevators", "Leave")
	   labelc.Text = "Someone joined.."
	   module:Map(Map, Bool, Mode)
	   sp:Disconnect()
	   break
	 end
       end
     end)
  end
  
  if not typeof(Elevator) == "table" then
    labelc.Text = "Force changing maps.."
    local status = core:ForceChangeMaps()
    repeat
      wait()
    until status == true
    module:Map(Map, Bool, Mode)
    break
  end
end

return module
