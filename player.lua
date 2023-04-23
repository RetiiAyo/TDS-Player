local module = {}
local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/functions.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/RBXScripts-Drive/main/girgmnijnrw09LIB.lua"))()
local labelc = nil

function module:Loadout(T1, T2, T3, T4, T5)
  module:Connect()
  if functions:IsGame() then
    print("in-game")
  else
    
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
    
  local RS = game:GetService("ReplicatedStorage")
  local RSRE = RS:WaitForChild("RemoteEvent")
  local RSRF = RS:WaitForChild("RemoteFunction")

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
  local elev = false
  local function getElevators()
     local L = game.ReplicatedStorage.RemoteFunction
  for a, c in pairs(game:GetService('Workspace').Elevators:GetChildren()) do
    local a = require(c.Settings)
    local b = c.State.Players.Value
    local c2 = c.State.Map.Title.Value
    
    if c2 == Map and b == 0 and a.Type == Mode then
	L:InvokeServer("Elevators", "Enter", c)
	elev = true
	labelc.Text = "Joined.."
	spawn(function()
	    c.State.Players:GetPropertyChangedSignal("Value"):Connect(function()
		if b > 0 then
		    labelc.Text = "Someone joined.."
		    L:InvokeServer("Elevators", "Leave")
		end
	    end)
	end)
    end
  end
  end

  if elev == false then
      repeat
	labelc.Text = "Force changing maps.."
        local L = game.ReplicatedStorage.RemoteFunction
      for a, c in pairs(game:GetService('Workspace').Elevators:GetChildren()) do
        local a = require(c.Settings).Type
        local b = c.State.Players
        if a == Mode and b.Value <= 0 then
          L:InvokeServer("Elevators", "Enter", c)
          wait(1)
          L:InvokeServer("Elevators", "Leave")
      end
      wait(5)
      getElevators()
      wait(1)
      until elev == true
   end
   wait(0.6)
   L:InvokeServer("Elevators", "Leave")
   wait(1)
   labelc.Text = "Restarting.."
   module:Map(Map, Bool, Mode)
  end
end

function module:Connect()
  print("Connected!")
end

return module
