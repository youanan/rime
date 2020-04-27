--无障碍版专用脚本
require "import"

function updateComposing(i,c,t)
  if t == "笑话" then  --随机在线笑话
    require "script.random_joke"
    jokes()
  elseif t == "每日" then  --在线每日语句
    require "script.daily_word"
    words()
  elseif i == "/ci" then  --本地随机诗词
    require "script.poetry"
    poetry()
  elseif i == "/sc" then  --随机sentence
    require "script.sentence"
    sentence()
  elseif i == "/se" then  --随机sentence
    require "script.random_sentence"
    sentence()
  end
end
