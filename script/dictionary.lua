require "import"
import "android.content.Context"

local word = (...)

local host = "https://www.mxnzp.com/api"
local path= "/convert/dictionary?content="
local f,e= tostring(service.getLuaExtDir("script/key.lua"))
if e == nil then
  require "script.key"
  local id,keys = idkey()
  url = host..path..word.."&"..id..keys
else
  url = host..path..word
end

--service.getSystemService(Context.CLIPBOARD_SERVICE).setText(url)
--写入剪贴板


Http.get(url,function(a,b)
  if a==200 then
    local json = require "cjson"
    code = json.decode(b)
    if code.code == 1 then
      t = code.data[1]
      cword = t.word         --单字
      tword = t.traditional  --繁体
      pinyin = t.pinyin      --拼音
      radicals = t.radicals  --偏旁
      exp = t.explanation   --释文
      --ss,ee = string.find(exp,cword..pinyin)
      --exp2 = string.gsub(exp,"\n\n","\n")
      --exp3 = string.sub(exp2,ee-3,#exp-3)
      exp2 =exp:match(cword..pinyin.."(.+)")
      strokes = math.ceil(t.strokes)     --笔画数
      l1 = "┏┄┄┓ 读音: 【"..pinyin.."】\n"
      l2 = "┆  "..cword.."  ┆ 部首: 【 "..radicals.."  】\n"
      l3 = "┗┄┄┛ 笔画: 【 "..strokes.."    】\n"
      l4 = "释义:  ┅┅┅┅┅┅┅\n"
      l5 = exp2
      task(10,function()
        service.addCompositions({l1..l2..l3..l4..l5}) end)
      else
        print("只可以查单字哦！")
      end
  else
    print("网络似乎出了问题")
  end
end)



