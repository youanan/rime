require "import"

--[[
字典post返回内容
<meta http-equiv="refresh" content="0;URL=./zi518d.html"><script>document.location.href="./zi518d.html";</script>
]]


local a=(...)
local zd = "https://mzidian.911cha.com"
local cd = "https://mcidian.911cha.com"
if #a == 3 then
  Http.post(zd.."/","q="..a,function(c,t)
  local html=t:match("URL=%.([^\"]+)")
  service.openUrl(zd..html)
  end)
elseif #a == 6 then
  Http.post(cd.."/","q="..a,function(c,t)
  local html=t:match("URL=%.([^\"]+)")
  service.openUrl(zd..html)
  end)
else
  print("只支持单字查询")
end
