
--[[
--无障碍版专用脚本
--用途：语音加信息提示
--如何使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 计算器.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键LuaNum，LuaNum1

preset_keys:
  VOICE_ASSIST0: {label: 计算, send: function, command: '语音加提示.lua', option: "%1$s"}
  

向该方案任意按键加入上述按键既可，推荐在空格键长按启动

]]


require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"

Toast.makeText(service, "语音已启动，请讲话😀",Toast.LENGTH_SHORT).show()
--调用同文语音按键
service.sendEvent("VOICE_ASSIST")

--service.sendEvent("{label: 🎙️, functional: true, send: VOICE_ASSIST}")

