require "import"
import "android.content.Context"
import "java.io.File"--导入File类
import "android.widget.*"

--获取剪切板内容

words= (...)

print("["..words.."]")

local user_dict = service.getLuaExtDir().."/wubi86_jidian_user.dict.yaml"
local user_txt = service.getLuaExtDir().."/user.txt"

if words ~= nil and string.find(words,"|") ~= nil then
  local txt = words:match("(.+)|")
  local code = words:match("|(.+)")
  local t = txt.."\t"..code.."\n"


  if File(fp).exists() then

    io.open(fp,"a"):write(t):close()
    otxt = "【"..txt.."】已加入到用户词典!\n编码:【"..code.."】重新布署后生效!"
    Toast.makeText(service,otxt, Toast.LENGTH_LONG).show()
   --print("【"..txt.."】已加入到用户词典!\n编码:【"..code.."】重新布署后生效!")
    --service.getSystemService(Context.CLIPBOARD_SERVICE).setText(nil)
--写入剪贴板
    
  else
    print("用户词典文件不存在!需要在脚本中指定.")
  end
else
  --service.getSystemService(Context.CLIPBOARD_SERVICE).setText(nil)
  print("剪切板没有内容或格式不对!格式: 文字|编码")
end

