local module = {}
local core = {}

local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/storage/functions.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/RBXScripts-Drive/main/girgmnijnrw09LIB.lua"))()
local labelc

local RS = game:GetService("ReplicatedStorage")
local RSRE = RS:WaitForChild("RemoteEvent")
local RSRF = RS:WaitForChild("RemoteFunction")

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

return module
