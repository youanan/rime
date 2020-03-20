require "import"
import "java.io.File"

function sentence()
  local f,e= tostring(service.getLuaExtDir("data/chinese-gushiwen/sentence/sentence1-10000.json"))
  if e == nil then
    local json = require "cjson"
    local file = io.open(f):read("*a")
    local s = json.decode(file)
    local sum  = 0    --总数量
    for k,v in pairs(s) do
      sum  = sum + 1
    end
    local no = math.random(1,sum)
    local txt = s[no].name.."\n"
    local from = "["..s[no].from.."]\n"
    service.addCompositions({txt..from})
  else
    print("文件不存在")
  end
end
