--[[
--无障碍版专用脚本
--有道翻译
--版本号: 1.1
--新增翻译【剪切板】内容
--说明: 
▂▂▂▂▂▂▂▂
日期: 2020年03月08日🗓️
农历: 鼠(庚子)年二月十五
时间: 21:30:55🕘
星期: 周日

http://fanyi.youdao.com/openapi.do?keyfrom=wufeifei&key=716426270&type=data&doctype=json&version=1.1&q=gym

{
  "translation":["健身房"],
   "basic":{
     "us-phonetic":"dʒɪm",
     "phonetic":"dʒɪm",
     "uk-phonetic":"dʒɪm",
     "explains":["n. 健身房；体育；体育馆"]},
   "query":"gym",
   "errorCode":0,
   "web":[
   {"value":["健身房","体育馆","健身馆"],
       "key":"Gym"},
   {"value":["钢架","丛林健身房","立体方格铁架"],"key":"jungle gym"},
   {"value":["健身中心服务员","健身房服务员","今天"],"key":"Gym Attendant"}]
}

]]

require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context" 


local 候选 = (...)
local 实际内容=候选
local 翻译类型="AUTO"


if string.sub(候选,1,1)!="<" && string.sub(候选,#候选-9,#候选-9)=="<" && string.sub(候选,#候选,#候选)==">" then
 实际内容=string.sub(候选,1,#候选-10)
 实际内容=string.gsub(实际内容,"'"," ")
 实际内容=string.gsub(实际内容,"%.","")
 翻译类型=string.sub(候选,#候选-8,#候选-1)
end

if string.sub(候选,1,1)=="<" then
 实际内容=tostring(service.getSystemService(Context.CLIPBOARD_SERVICE).getText()) --获取剪贴板 
 翻译类型=string.sub(候选,#候选-8,#候选-1)
end


--http://fanyi.youdao.com/translate?&doctype=json&type="<ZH_CN2EN>"&i=你好"
--http://fanyi.youdao.com/translate?&doctype=json&type="<EN2ZH_CN>"&i=gym"


--Toast.makeText(service, 翻译类型,Toast.LENGTH_SHORT).show() --弹出信息

local 云输入内容="http://fanyi.youdao.com/translate?&doctype=json&type="..翻译类型.."&i="..实际内容

Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 if a==200 then 
  if string.find(b,"ip的请求异常频繁")!=nil then
   print("有道检测ip请求频繁,建议切换网络")
   return
  end
 json=import"cjson"
 --print(tostring(b))
 local jx=json.decode(b)
 local 翻译内容=jx.translateResult[1][1].tgt
 --{"type":"ZH_CN2JA","errorCode":0,"elapsedTime":1,"translateResult":[[{"src":"有道翻译","tgt":"努めれ翻訳"}]]}
 local 内容1=翻译内容..".("..实际内容..")"
 task(100,function()
  service.addCompositions({实际内容,内容1}) end)
 else
 print("网络似乎出了问题")
 end
 end)

