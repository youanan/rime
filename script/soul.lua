require "import"
import "java.io.File"

function soul()
  local f,e= tostring(service.getLuaExtDir("data/soul.json"))
  if e == nil then
    local json = require "cjson"
    local file = io.open(f):read("*a")
    local s = json.decode(file)
    --[[   已计算出总数量有2020个
    local sum  = 0    --总数量
    for k,v in pairs(s) do
      sum  = sum + 1
    end
    print(sum)]]
    local no = math.random(1,2020)
    local txt = s[no].content
    service.addCompositions({txt})
  else
    print("文件不存在")
  end
end
