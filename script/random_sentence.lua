
function sentence()
  local host = "https://v2.jinrishici.com/sentence"
  local headers = {["X-User-Token"] = "29iA1kheGg9cFVVh5Iv8ADQZx+e/YaXl"}
  Http.get(host,nil,"utf-8",headers,function(a,b)
    local json = require "cjson"
    if a==200 then
      t = json.decode(b).data
      local txt = table.concat(t.origin.content).."\n"
      local title = t.origin.title.."\n"
      local author = t.origin.author.."\n"
      task(10,function()
        service.addCompositions({t.content}) end)
    else
      t = json.decode(b)
      print("网络似乎出了问题"..t.errCode)
    end
  end)
end



