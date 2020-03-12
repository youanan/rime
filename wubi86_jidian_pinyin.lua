--[[
--无障碍版专用脚本
--自动脚本_笑话云
--用途：
⒈笑话云，打 笑话，随机出相关内容

--配置说明
第①步 放置在rime目录下，改成和方案同名的lua如luna_pinyin.lua 
第②步 无障碍设置界面，打开悬浮窗口
第③步 关掉键盘，键盘刷新后就可以看到效果，需要打开悬浮窗口

]]

require "import"
import "cjson"
import "java.io.File"
import "android.widget.*"
import "android.content.Context" 
import "android.view.*"




--检测候选栏内容
--[i:编码,c:预处理后,t:高亮候选]
function updateComposing(i,c,t)

  --自动笑话
  if t=="笑话" then
    --随机笑话 api.sjxh
    sjxh_api = apis("sjxh","/jokes/list/random")
    d=getcontent(sjxh_api)
    service.addCompositions({d[1]["content"]})  --内容到候选窗口
  end  --end自动笑话
  if t == "每日" then
    --每日语句 api.mryj
    mryj_api = apis("mryj","/daily_word/recommend?count=1")
    d=getcontent(mryj_api)
    service.addCompositions({d[1]["content"]})  --内容到候选窗口
  end
  --自动日期
  if t=="日期" then
    service.addCompositions({os.date("%Y-%m-%d %H:%M:%S")})
  end --end 自动日期
  if t=="诗词" then
    showinfo(mryj_api)
  end

end

--[[
--读取本地json文件
function localjson()
local f=tostring(service.getLuaExtDir("data")).."/poet.song.0.json"
local cont=io.open(f):read("*a")
local json = require "cjson"
local conts=json.decode(cont)
local author = conts[1]["author"]
local parag1 = conts[1]["paragraphs"][1]
local parag2 = conts[1]["paragraphs"][2]
local title = conts[1]["title"]
local id = conts[1]["id"]
task(300,function() service.addCompositions({conts[1]["author"],conts[1]["paragraphs"][1],conts[1]["paragraphs"][2],conts[1]["title"],conts[1]["id"]})
 end)
end
]]
--function djson()
--local 文件=tostring(service.getLuaExtDir("data")).."/chinese-poetry/json/poet.song.0.json"
--local cont=io.open(文件):read("*a")

--local json = require "cjson"
--local 内容组=json.decode(cont) 

--end
--获取api数据,并返回json格式
function getcontent(api)
    Http.get(api, function(c,txt)
     if c==200 then
        code=cjson.decode(txt).code
        if code==1 then
           content=cjson.decode(txt).data
         end  --end code==1
       end  --end c==200
     end)
    return content
end

--mxnzp api组合函数,参数:(简称,网址参数)
function apis(tag,arg)
host = "https://www.mxnzp.com/api"
local tag = tag
local arg = arg
if pcall(apikeys) then
  local idkey = apikeys()   --id&key
  path = host..arg..idkey
else
  idkey  = nil
  path = host..arg
end
return path
end

--mxnzp.com专用,读取apikeys
--key文件存放在: rime/script/api.json
function apikeys()
  local f = tostring(service.getLuaExtDir("script")).."/api.json"
  local txt=io.open(f):read("*a")
  local json = require "cjson"
  local apis = json.decode(txt)
  local id = apis["id"]
  local key = apis["key"]
  keys = id..key
  return keys
end

-- 通用函数，提示消息,txt参数为消息内容
function showinfo(txt)
  Toast.makeText(service,txt,Toast.LENGTH_SHORT).show()
end  --end 通用函数，提示消息

