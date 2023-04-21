local module = {}

function module:CheckForPlayers(PlayerTable)
  local Plrs = {}
  for i, v in pairs(game.Players:GetPlayers()) do
    if PlayerTable[v.Name] then
      Plrs[v.Name] = {["UserId"] = v.UserId}
    end
  end
  
  return Plrs
end

return module
