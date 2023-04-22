local module = {}

function module:SendWebhook(Data)
  if getgenv().Settings.Logs ~= "WEBHOOK HERE (NOT NEEDED)" then
    print("Web1")
    local Url = getgenv().Settings.Logs
    local Headers = {["content-type"] = "application/json"}
    local Request = http_request or request or HttpPost or syn.request
    local FullData = {Url = Url, Body = Data, Method = "POST", Headers = Headers}
    Data = game:GetService("HttpService"):JSONEncode(Data)
    
    print("Web2")
    
    Request(FullData)
    print(FullData)
  end
end

return module
