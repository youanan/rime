--[[
无障碍版专用脚本
随机语句,悬浮窗口本地版脚本
根据关键字显示随机语句,
数据源使用本地文件,默认路径Android/rime/data目录下
无需网络,内容可以自定义
一行代表一条语句,如需语句多行显示,请在所在行中插入<br>表示换行
用途：请根据需要自行定制

--配置说明
第①步 放置在rime目录下，改成和方案同名的lua如luna_pinyin.lua 
第②步 无障碍设置界面，打开悬浮窗口
第③步 关掉键盘，键盘刷新后就可以看到效果，需要打开悬浮窗口

]]
--require "import"
--import "cjson"
--import "android.widget.*"
--import "java.io.File"

--功能函数
--悬浮窗口随机语句,数据文件默认Android/rime/data目录下
fpath=tostring(service.getLuaExtDir())
print(fpath)
--[[
function 随机语句(文件)
    行数=0
    路径=tostring(service.getLuaExtDir("data")).."/"..文件
    print(路径)
    for c in io.lines(路径) do
     行数=行数+1
    end
    随机行数=math.random(1,行数)
    行数2=0
    for c in io.lines(路径) do
     行数2=行数2+1
     if 行数2==随机行数 then
      c=string.gsub(c,"<br>","\n")
      service.addCompositions({c}) 
      break
     end
    end
end






--自动脚本通用函数,上屏后的处理
function commitText(内容)
--Toast.makeText(service, "当前上屏了 "..内容,Toast.LENGTH_SHORT).show() 
end



--自动脚本通用函数,当前候选,i表示编码,c待测,t表示候选内容
function updateComposing(i,c,t)
  --聊天技巧随机版,数据文件,默认Android/rime/data目录下
  if t=="笑话" then  随机语句("笑话.txt") end

  --聊天话题随机版


end
]]
