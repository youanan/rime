require "import"
import "android.content.*"

--获取系统剪切板 快递单号
local exNo = tostring(service.getSystemService(Context.CLIPBOARD_SERVICE).getText())


local host = "https://www.mxnzp.com/api"
local getid= "/logistics/discern?logistics_no="..exNo    --获取快递公司id api参数


--获取本地key
local f,e= tostring(service.getLuaExtDir("script/key.lua"))
if e == nil then
  require "script.key"
  local id,keys = idkey()
  getidurl = host..getid.."&"..id..keys
  idkeys = "&"..id..keys
else
  getidurl = host..getid
end


--service.getSystemService(Context.CLIPBOARD_SERVICE).setText(getidurl)

--获取快递公司分类id
Http.get(getidurl,function(a,b)
if a==200 then    --if2
  local json = require "cjson"
  local exdata = json.decode(b).data
  exId = exdata.searchList[1].logisticsTypeId
  typeId = math.ceil(exId)

  local info_url = host.."/logistics/details/search?logistics_no="..exNo.."&logistics_id="..typeId..idkeys     --获取快递详细进度

  --获取快递详细信息
  Http.get(info_url,function(c2,d2)
    if c2==200 then    --if2
      --local json = require "cjson"
      local d0= json.decode(d2).data
      local t1= "🚚"..d0.logisticsType..":"..exNo.."\n"
      local t2 = "📦状态:"..d0.status.."\n"
      infos = {}
      table.insert(infos,t1)
      table.insert(infos,t2)
      table.insert(infos,"⇀⇀⇀⇀⇀⇀⇀⇀⇀⇀⇀⇀⇀\n")

      local dd =d0.data
      for i,k in ipairs(dd) do
        local desc = "◉ "..dd[i].desc.."\n"
        local time = "⏱ "..dd[i].time.."\n\n"
        table.insert(infos,desc)
        table.insert(infos,time)
      end
      alltxt = table.concat(infos)
      service.getSystemService(Context.CLIPBOARD_SERVICE).setText(alltxt)
      print("查询成功，快递详情已发送到剪切板！")
    else
      print("快递详情网络连接失败！")
    end  --if2
  end)

else
  print("快递类型网络连接失败！")
end  --if2

end)

