local module = {}

function module:SendWebhook(Webhook, Data)
  print("Sending webhook")
  syn.request({
      Url = tostring(Webhook),
      Body = game:GetService("HttpService"):JSONEncode(Data),
      Method = "POST",
      Headers = {
        ["content-type"] = "application/json"
      }
  })
end

return module
