
require "import"
import "android.content.Context"
import "java.io.File"--导入File类
import "android.widget.*"

local op = (...)
local word = tostring(service.getSystemService(Context.CLIPBOARD_SERVICE).getText()) --获取剪贴板 
if op == nil then
  local url = "http://www.eggvod.cn/music/?name="..word.."&type=ximalaya"
else
  local url = "http://www.eggvod.cn/music/?name="..op.."&type=ximalaya"
end

local headers = {
  ["User-Agent"] = 'Mozilla/5.0 (Linux; Android 8.1.0; MI 8 SE) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.92 Mobile Safari/537.36',
  ["Accept"] = "application/json, text/javascript, */*; q=0.01",
  ["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8",
  ["Referer"] = url,
}

local host = "http://www.eggvod.cn/music/"
--Http.post(url,data,cookie,charset,header,callback)
local data = {}
data.input = word
data.filter = "name"
data.type = "ximalaya"
data.page= "1"

Http.post(host,data,nil,"utf-8",headers,function(a,b)

--Http.get(url,nil,"utf-8",nil,function(a,b)
if a==200 then 
  --local json = require "cjson"
  --local t = json.decode(b)
  --local title = t.data[1].title
  --local url = t.data[1].url
  --service.getSystemService(Context.CLIPBOARD_SERVICE).setText(b)
--写入剪贴板
  service.openUrl(url)
  print("成功!")

else
 print("网络似乎出了问题")
end end)
