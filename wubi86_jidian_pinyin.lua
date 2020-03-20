--无障碍版专用脚本
require "import"

function updateComposing(i,c,t)
  if t == "笑话" then  --随机笑话
    require "script.random_joke"
    jokes()
  elseif t == "每日" then  --每日语句
    require "script.daily_word"
    words()
  elseif t == "鸡汤" then  --随机鸡汤
    require "script.soul"
    soul()
  elseif i == "/ci" then  --随机诗词
    require "script.poetry"
    poetry()
  elseif i == "/sc" then  --随机sentence
    require "script.sentence"
    sentence()
  elseif i == "/se" then  --随机sentence
    require "script.random_sentence"
    sentence()
  elseif i == "/he"  then  --和风天气
    require "script.heweather"
    heweather()
  end
end
