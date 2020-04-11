
function jokes()
  local host = "https://www.mxnzp.com/api"
  local sjxh = "/jokes/list/random"
  local f,e= tostring(service.getLuaExtDir("script/key.lua"))
  if e == nil then
    require "script.key"
    local id,keys = idkey()
    url = host..sjxh.."?"..id..keys
  else
    url = host..sjxh
  end

  Http.get(url,nil,"utf-8",nil,function(a,b)
    if a==200 then
      local json = require "cjson"
      t = json.decode(b)
      if t.code == 0 then
        print(t.msg)
      else
      list = {}
      for i=1,3 do
        list[i] = t.data[i].content
        end
      task(10,function()
      service.addCompositions(list)
      end)
      end
    else
      print("网络似乎出了问题")
    end
  end)
end



