require "import"

condidate= (...)
local city = "location="..condidate
local host = "https://free-api.heweather.net/s6/weather/forecast?"

local f,e= tostring(service.getLuaExtDir("script/key.lua"))
if e == nil then
  require "script.key"
  key = heweather_key()
else
  print("api key文件不存在,去和风api申请")
end

local url = host..city..key

Http.get(url,nil,"utf-8",nil,function(a,b)
  local json = require "cjson"
  if a==200 then
    t = json.decode(b).HeWeather6[1]
    local area=t.basic.admin_area
    local city=t.basic.parent_city
    local city = "📍"..area.."•"..city.."\n"
    local update= "🕕:"..t.update.loc.."\n"
    local day1 = t.daily_forecast[1]
    local day2 = t.daily_forecast[2]
    local day3 = t.daily_forecast[3]

    local d1cond = day1.cond_txt_d.."~"..day1.cond_txt_n  --今天白天到夜间
    local d1coded = day1.cond_code_d
    local d1coden = day1.cond_code_n
    local d1_tmp_max=day1.tmp_max
    local d1_tmp_min=day1.tmp_min
    local d1tmp=d1_tmp_min.."~"..d1_tmp_max.."℃ "   --今天气温
    local d1_wind=day1.wind_dir --风向
    local d1_wind_sc=day1.wind_sc --风力
    local d1wind = d1_wind..d1_wind_sc.."级"     --今天风向风级

    local d2cond = day2.cond_txt_d.."~"..day2.cond_txt_n  --明天白天到夜间
    local d2coded = day2.cond_code_d
    local d2coden = day2.cond_code_n
    local d2_tmp_max=day2.tmp_max
    local d2_tmp_min=day2.tmp_min
    local d2tmp=d2_tmp_min.."~"..d2_tmp_max.."℃ "   --明天气温
    local d2_wind=day2.wind_dir --风向
    local d2_wind_sc=day2.wind_sc --风力
    local d2wind = d2_wind..d2_wind_sc.."级"     --明天风向风级

    local d3cond = day3.cond_txt_d.."~"..day3.cond_txt_n  --后天白天到夜间
    local d3coded = day3.cond_code_d
    local d3coden = day3.cond_code_n
    local d3_tmp_max=day3.tmp_max
    local d3_tmp_min=day3.tmp_min
    local d3tmp=d3_tmp_min.."~"..d3_tmp_max.."℃ "   --后天气温
    local d3_wind=day3.wind_dir --风向
    local d3_wind_sc=day3.wind_sc --风力
    local d3wind = d3_wind..d3_wind_sc.."级"     --后天风向风级
    --[[67 lines emoji
    local emoji = {}
    function toemoji(x)
    local x = tostring(x)
    emoji[100] = "⛅⛱️"   --Sunny/Clearg
    emoji[101] = "🌥️"   --Cloudyg
    emoji["少云"] = "🌥️"  --Few Cloudsg
    emoji["晴间多云"] = "🌥️"   --Partly Cloudyg
    emoji[104] = "☁️"  --Overcastg
    emoji["有风"] = "🌬️"   --Windyg
    emoji["平静"] = "🏕️"  --Calmg
    emoji["微风"] = "🌬️"  --Light Breezeg
    emoji["和风"] = "🌬️" --Moderate/Gentle Breezeg
    emoji["清风"] = "🌬️"   --Fresh Breezeg
    emoji["强风/劲风"] ="🌬️🌬️"  --Strong Breezeg
    emoji["疾风"] = "🌬️🌬️🌬️"  --High Wind, Near Galeg
    emoji["大风"] = "🌬️🌬️🌬️"  --Galeg
    emoji["烈风"] = "🌬️🌬️🌬️🌬️"  --Strong Galeg
    emoji["风暴"] = "🌬️🌬️🌬️🌬️🌬️"  --Stormg
    emoji["狂爆风"] = "🌬️🌬️🌬️🌬️🌬️🌬️"  --Violent Stormg
    emoji["飓风"] = "🌀" --Hurricaneg
    emoji["龙卷风"] = "🌪️"  --Tornadog
    emoji["热带风暴"] = "🌀🌀"  --Tropical Stormg
    emoji["阵雨"] = "☀️🌧️☀️"  --Shower Raing
    emoji["强阵雨"] = "☀️🌧️🌧️☀️"  --Heavy Shower Raing
    emoji["雷阵雨"] = "☀️⛈️☀️"  --Thundershowerg
    emoji["强雷阵雨"] = "☀️⛈️⛈️☀️"  --Heavy Thunderstormg
    emoji["雷阵雨伴有冰雹"] = "☀️⛈️☄️☀️"  --Thundershower with hailg
    emoji["小雨"] = "🌧️"   --Light Raing
    emoji["中雨"] = "🌧️" --Moderate Raing
    emoji["大雨"] = "🌧️"  --Heavy Raing
    emoji["极端降雨"] = "🌧️"  --Extreme Raing
    emoji["毛毛雨/细雨"] = "🌧️"  --Drizzle Raing
    emoji["暴雨"] = "🌧️🌧️"  --Stormg
    emoji["大暴雨"] = "🌧️🌧️"  --Heavy Stormg
    emoji["特大暴雨"] = "🌧️🌧️"  --Severe Stormg
    emoji["冻雨"] = "🌧️🌧️"  --Freezing Raing
    emoji["小到中雨"] = "🌧️🌧️"  --Light to moderate raing
    emoji["中到大雨"] = "🌧️🌧️"  --Moderate to heavy raing
    emoji["大到暴雨"] = "🌧️🌧️"  --Heavy rain to stormg
    emoji["暴雨到大暴雨"] = "🌧️🌧️"  --Storm to heavy stormg
    emoji["大暴雨到特大暴雨"] = "🌧️🌧️"  --Heavy to severe stormg
    emoji["雨"] = "🌧️🌧️"  --Raing
    emoji["小雪"] = "🌨️"   --Light Snowg
    emoji["中雪"] = "🌨️"  --Moderate Snowg
    emoji["大雪"] = "🌨️"  --Heavy Snowg
    emoji["暴雪"] = "🌨️"  --Snowstormg
    emoji["雨夹雪"] = "🌨️"  --Sleetg
    emoji["雨雪天气"] = "🌨️"  --Rain And Snowg
    emoji["阵雨夹雪"] = "🌨️"  --Shower Snowg
    emoji["阵雪"] = "🌨️"  --Snow Flurryg
    emoji["小到中雪"] = "🌨️"  --Light to moderate snowg
    emoji["中到大雪"] = "🌨️"  --Moderate to heavy snowg
    emoji["大到暴雪"] = "🌨️"  --Heavy snow to snowstormg
    emoji["雪"] = "🌨️"  --Snowg
    emoji["薄雾"] = "🌫️"  --Mistg
    emoji["雾"] = "🌫️"  --Foggyg
    emoji["霾"] = "🌫️"  --Hazeg
    emoji["扬沙"] = "🌫️"  --Sandg
    emoji["浮尘"] = "🌫️"  --Dustg
    emoji["沙尘暴"] = "🌫️"  --Duststormg
    emoji["强沙尘暴"] = "🌫️"  --Sandstormg
    emoji["浓雾"] = "🌫️🌫️"  --Dense fogg
    emoji["强浓雾"] = "🌫️🌫️"  --Strong fogg
    emoji["中度霾"] = "🌫️🌫️"  --Moderate hazeg
    emoji["重度霾"] = "🌫️🌫️"  --Heavy hazeg
    emoji["严重霾"] = "🌫️🌫️"  --Severe hazeg
    emoji["大雾"] = "🌫️"  --Heavy fogg
    emoji["特强浓雾"] = "🌫️🌫️"  --Extra heavy fogg
    emoji["热"] = "🔥"   --Hotg
    emoji["冷"] = "⛄"  --Coldg
    emoji["未知"] = "🌝"   --Unknowng
    for k,v in ipairs(emoji) do
      if k == x then
        print(type(x)..emoji[k])
        return emoji.k
      end
    end
   end
   ]]

    local l1 = city
    local l2 = update
    local l3 ="▃▃▃▃▃▃▃▃▃▃▃\n"
    local l4_1 = day1.cond_txt_n
    local l4_2 = day1.cond_txt_d
    local l4 = "今天 :"..l4_1.."/"..l4_2.."\n"
    local l5 = "╚🌡️: "..d1tmp..d1wind.."\n"
    local l6_1 = day2.cond_txt_n
    local l6_2 = day2.cond_txt_d
    local l6 = "明天: "..l6_1.."/"..l6_2.."\n"
    local l7 = "╚🌡️: "..d2tmp..d2wind.."\n"
    local l8_1 = day3.cond_txt_n
    local l8_2 = day3.cond_txt_d
    local l8 = "后天: "..l8_1.."/"..l8_2.."\n"
    local l9 = "╚🌡️: "..d3tmp..d3wind
    task(10,function()
      --重新取得天气文字
      local totxt = l1..l2..l3..l4..l5..l6..l7..l8..l9
      service.addCompositions({totxt}) 
    end)
  else
    print("网络似乎出了问题")
  end
end)


