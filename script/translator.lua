require "import"
--import "android.app.*"
import "android.os.File"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"

local condidate = (...)

local host = "https://www.mxnzp.com/api"
local args= "/convert/translate?content=我是一个好人&from=zh&to=en"
--[[
zh-中文，en-英文，yue-粤语，wyw-文言文，jp-日语，kor-韩语，fra-法语，spa-西班牙语，th-泰语，ara-阿拉伯语，ru-俄语，pt-葡萄牙语，de-德语，it-意大利语，el-希腊语，nl-荷兰语，pl-波兰语，bul-保加利亚语，est-爱沙尼亚语，dan-丹麦语，fin-芬兰语，cs-捷克语，rom-罗马尼亚语，slo-斯洛文尼亚语，swe-瑞典语，hu-匈牙利语，cht-繁体中文，vie-越南语
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



