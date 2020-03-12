--[[
--无障碍版专用脚本
--用途：英语4w简明词典，可查选中候选英语词汇,若屏幕无候选,可查编辑框选中文本,释义显示在悬浮窗口
--版本号: 1.0
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月08日🗓️
农历: 鼠(庚子)年二月十五
时间: 11:18:47🕚
星期: 周日
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)
--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 英语4w简明词典/英语4w简明词典.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键

preset_keys:
  lua_dic_4w_en: {label: 翻译, send: function, command: '英语4w简明词典/英语4w简明词典.lua', option: "%1$s"} #英语单词»中文释义


向该主题方案任意按键加入上述按键既可
]]

require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.Context" 


local 候选 = (...)
local 翻译组 ={}
local 文件=tostring(service.getLuaExtDir("script/英语4w简明词典/dic_4w_en.txt"))
local 内容存在=false
for 行内容 in io.lines(文件) do
 if string.lower(string.sub(行内容,1,#候选+1))==string.lower(候选.."\t") then
 翻译组[1]=候选
 翻译组[2]=string.sub(行内容,#候选+1,#行内容)
 内容存在=true
 end
end

if 内容存在 then
 task(300,function()
  service.addCompositions(翻译组)
  end)
else
 Toast.makeText(service, 候选.."无相关内容",Toast.LENGTH_SHORT).show() --弹出信息
end


