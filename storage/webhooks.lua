local module = {}

function module:SendWebhook(Webhook, Data)
  syn.request({ Url = Webhook, Body = game:GetService("HttpService"):JSONEncode(Data), Method = "POST", Headers = {["content-type"] = "application/json"} })
  print(FullData[1])
end

return module
