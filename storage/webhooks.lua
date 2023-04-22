local module = {}

function module:SendWebhook(Data)
  if getgenv().Settings.Logs ~= "WEBHOOK HERE (NOT NEEDED)" then
    print("Web1")
    local url = getgenv().Settings.Logs
    local headers = {["content-type"] = "application/json"}
    local Request = http_request or request or HttpPost or syn.request
    local FullData = {Url = url, Body = Data, Method = "POST", Headers = headers}
    
    print("Web2")
    
    syn.request({ Url = url, Body = game:GetService("HttpService"):JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"} })
    print(FullData)
  end
end

return module
