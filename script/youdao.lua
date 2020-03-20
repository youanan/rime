require "import"
--import "android.app.*"
import "android.os.File"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"

local condidate = (...)

local host = "https://openapi.youdao.com/api"
local q = "你好"
local from = "zh-CHS"
local to = "en"
local appKey = "0ed0548eec422432"
local salt = 
local sign = 
local curtime = 
--[[
]]











  local f,e= tostring(service.getLuaExtDir("script/key.lua"))
  if e == nil then
    require "script.key"
    local id,keys = youdaokey()
    url = host..sjxh.."?"..id..keys
  else
    url = host..sjxh
  end
  Http.get(url,function(a,b)
    if a==200 then
      local json = require "cjson"
      t = json.decode(b).data
      task(10,function()
        service.addCompositions({t[1]["content"]}) end)
    else
      print("网络似乎出了问题")
    end
  end)



