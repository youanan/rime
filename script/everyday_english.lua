require "import"
import "android.content.Context"
import "java.io.File"--导入File类
import "android.widget.*"

--[[
if 本地文件存在
   读取文件
  if 如果有今天日期
     输出本地当天日期内容
  else 没有今天日期
     获取网上内容输出()
     追加当天到本地()
  end
else 如果本地主文件不存在
     获取网上内容输出()
     追加当天到本地()
end
--]]

local fp = service.getLuaExtDir().."/data/everyday_english.txt"

function get_iciba()  --#3
  local host = "http://open.iciba.com/dsapi/"
  Http.get(host,nil,"utf8",nil,function(a,b)
  if a==200 then 
    local json = require "cjson"
    local t = json.decode(b)
    en = t.content
    cn = t.note
    dt = tostring(os.date("%Y-%m-%d"))
    txt = en.."("..cn..")"
    io.open(fp,"a"):write(dt.."\t"..txt.."\n"):close()
    service.addCompositions({txt})
  else
   print("网络似乎出了问题")
  end end)
end

if File(fp).exists() then  --文件存在时:
  local now=tostring(os.date("%Y-%m-%d"))
  local pattern = '([%d%-]+)\t(.+)'
  local li = {}
  for l in io.lines(fp) do
    for a,b in string.gmatch(l,pattern) do
      if a == now then   --有今天日期时:
        table.insert(li,1,b)
      end   --end if
    end    --end for
  end
  if li[1] ~= nil then
      --print("有今天日期")
      task(100,function() service.addCompositions(li)  end)
  else      --没今天今天日期时
      get_iciba()
      --print("无今天日期")
  end
else    --本地文件不存在时:
  get_iciba()
  --print("无本地文件")
end



