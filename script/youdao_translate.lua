--[[
--无障碍版专用脚本
--有道翻译
--版本号: 1.1
--新增翻译【剪切板】内容
--说明: 
--1.【编辑框选中文字】模式经测试小米max2_miui10.3上可用,其它系统可能存在兼容问题.若存在此问题,推荐复制到【剪切板】,再启用相关脚本功能
--2.经测试,中文»英语,中文»韩语,英语»中文可常用,其它短时间使用频繁的话易被有道检测为ip异常,脚本会报错,可切换网络通道避开
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月08日🗓️
农历: 鼠(庚子)年二月十五
时间: 21:30:55🕘
星期: 周日


--版本号: 1.0
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月07日🗓️
农历: 鼠(庚子)年二月十四
时间: 21:27:01🕘
星期: 周六
--用途：多国语言互译,可翻译【当前候选】,【编辑框选中文字】及【编码】,翻译内容在悬浮窗口显示
--说明: 【编码】翻译模式只支持将编码转成英文,然后翻译为中文,默认将分隔符转换为空格.目前分隔符只支持',其它待优化
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)
--目前支持以下语种间的转换
type的类型有：
AUTO 自动识别内容并翻译
ZH_CN2EN 中文　»　英语
ZH_CN2JA 中文　»　日语
ZH_CN2KR 中文　»　韩语
ZH_CN2FR 中文　»　法语
ZH_CN2RU 中文　»　俄语
ZH_CN2SP 中文　»　西语
EN2ZH_CN 英语　»　中文
JA2ZH_CN 日语　»　中文
KR2ZH_CN 韩语　»　中文
FR2ZH_CN 法语　»　中文
RU2ZH_CN 俄语　»　中文
SP2ZH_CN 西语　»　中文


--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 有道翻译.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键

preset_keys:
  #有道翻译,将【当前候选】,【编辑框选中文字】的中文内容转其它语种
  youdao_1: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2EN>"} #中文»英语
  youdao_2: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2JA>"} #中文»日语
  youdao_3: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2KR>"} #中文»韩语
  youdao_4: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2FR>"} #中文»法语
  youdao_5: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2RU>"} #中文»俄语
  youdao_6: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<ZH_CN2SP>"} #中文»西语

 #有道翻译,将【当前候选】,【编辑框选中文字】内容翻译为中文,如英语单词及句子
  youdao_7: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<EN2ZH_CN>"} #英语»中文
  youdao_8: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<JA2ZH_CN>"} #日语»中文
  youdao_9: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<KR2ZH_CN>"} #韩语»中文
  youdao_10: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<FR2ZH_CN>"} #法语»中文
  youdao_11: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<RU2ZH_CN>"} #俄语»中文
  youdao_12: {label: 翻译, send: function, command: '有道翻译.lua', option: "%1$s<SP2ZH_CN>"} #西语»中文

 #有道翻译,将【编码】转换为英语单词及句子,其中分隔符如'转换为空格,翻译成中文,
  youdao_13: {label: 翻译, send: function, command: '有道翻译.lua', option: "%2$s<EN2ZH_CN>"} #编码»英语»中文

  #有道翻译,将【剪切板】的中文内容翻译成其它语种
  youdao_cv1: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2EN>"} #中文»英语
  youdao_cv2: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2JA>"} #中文»日语
  youdao_cv3: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2KR>"} #中文»韩语
  youdao_cv4: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2FR>"} #中文»法语
  youdao_cv5: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2RU>"} #中文»俄语
  youdao_cv6: {label: 翻译, send: function, command: '有道翻译.lua', option: "<ZH_CN2SP>"} #中文»西语

 #有道翻译,将【剪切板】内容翻译为中文,如英语单词及句子
  youdao_cv7: {label: 翻译, send: function, command: '有道翻译.lua', option: "<EN2ZH_CN>"} #英语»中文
  youdao_cv8: {label: 翻译, send: function, command: '有道翻译.lua', option: "<JA2ZH_CN>"} #日语»中文
  youdao_cv9: {label: 翻译, send: function, command: '有道翻译.lua', option: "<KR2ZH_CN>"} #韩语»中文
  youdao_cv10: {label: 翻译, send: function, command: '有道翻译.lua', option: "<FR2ZH_CN>"} #法语»中文
  youdao_cv11: {label: 翻译, send: function, command: '有道翻译.lua', option: "<RU2ZH_CN>"} #俄语»中文
  youdao_cv12: {label: 翻译, send: function, command: '有道翻译.lua', option: "<SP2ZH_CN>"} #西语»中文

向该方案任意按键加入上述按键既可
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

