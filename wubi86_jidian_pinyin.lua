--无障碍版专用脚本
require "import"

function updateComposing(i,c,t)
  if t == "笑话" then  --随机笑话
    require "script.random_joke"
    jokes()
  elseif t == "每日" then  --每日语句
    require "script.daily_word"
    words()
  end
end
