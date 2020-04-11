--[[
--无障碍版专用脚本
--用途：剪切板到悬浮窗，读取中文输入法下clipboard.json剪切板文件内容,并显示在悬浮窗口
--bug: 剪切板内容\n会被换成
--版本号: 1.0
▂▂▂▂▂▂▂▂
日期: 2020年03月31日🗓️
农历: 鼠(庚子)年三月初八
时间: 09:21:08🕘
星期: 周二
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)

--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 剪切板到悬浮窗.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键

preset_keys:
  lua_cv_5: {label: ❐, send: function, command: '剪切板到悬浮窗.lua', option: "5"} #剪切板内容在悬浮窗显示,最多显示5个候选
  lua_cv_10: {label: ❐, send: function, command: '剪切板到悬浮窗.lua', option: "10"} #剪切板内容在悬浮窗显示,最多显示10个候选

向该方案任意按键加入上述按键既可
]]

require "import"
import "java.io.*"
import "android.content.Context" 
import "cjson"


local 参数 = (...)
local 候选个数 = tonumber(参数)
local 文件=tostring(service.getLuaDir("")).."/clipboard.json"
local 内容=io.open(文件):read("*a") --读取文件全部内容
local json = require "cjson"
local 剪切板组=json.decode(内容) 
local 剪切板子组={}
   if #剪切板组>候选个数 then
    for i = 1,候选个数 do 剪切板子组[i]=剪切板组[i] end 
   else
    剪切板子组=剪切板组
   end

task(100,function() service.addCompositions(剪切板子组)  end)
  



