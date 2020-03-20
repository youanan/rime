require "import"
import "java.io.File"

function poetry()
  local ts = {"tang","song"}
  local tn = ts[math.random(1,2)]
  --tn[1]tang唐诗: 0,57000,1000
  --tn[2]song宋词: 0,99000,1000
  if tn == "tang" then
    tname = "唐诗"
    fn = math.random(0,57)
  elseif tn == "song" then
    tname = "宋词"
    fn = math.random(0,99)
  end

  fno = tonumber(fn.."000")
  local f,e= tostring(service.getLuaExtDir("data/chinese-poetry-simplified/chinese-poetry/json/poet."..tn.."."..fno..".json"))
  if e == nil then
    local json = require "cjson"
    local file = io.open(f):read("*a")
    local s = json.decode(file)
    local sum  = 0    --总数量
    for k,v in pairs(s) do
      sum  = sum + 1
    end
    local no = math.random(1,sum)
    local txt = table.concat(s[no].paragraphs,"\n")
    local title = "\t《"..s[no].title.."》\n"
    local author = "["..s[no].author.."]\n"
    local info= "\n本地词库"..tname.."第"..fno.."分页".."第"..no.."条"
    service.addCompositions({title..author..txt..info})
    print(info)
  else
    print("文件不存在")
  end
end
