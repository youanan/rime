--[[
--无障碍版专用脚本
--用途：语音加信息提示
]]


require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"

service.sendEvent("VOICE_ASSIST")

Toast.makeText(service, "语音已启动，请讲话😀",Toast.LENGTH_SHORT).show()
--调用同文语音按键,preset_keys定义的键名
--service.sendEvent("{label: 🎙️, functional: true, send: VOICE_ASSIST}")

