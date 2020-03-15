
function words()
  local host = "https://www.mxnzp.com/api"
  local w="/daily_word/recommend?count=1&"
  require "script.key"
  local id,keys = idkey()
  local url = host..w..id..keys
  Http.get(url,nil,"utf8",nil,function(a,b)
  if a==200 then 
    local json = require "cjson"
    local t = json.decode(b).data
    task(10,function()
      service.addCompositions({t[1]["content"]}) end)
  else
   print("网络似乎出了问题")
  end end)
end



