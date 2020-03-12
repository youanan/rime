--[[
--无障碍版专用脚本
--用途：计算器，自动计算候选（表达式内容）结果，以及纯数字及计算结果转换成大写金额
--版本号: 1.2
--解决了数字中出现多个0时的问题

--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 计算器.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键LuaNum，LuaNum1

preset_keys:
  LuaNum: {label: 计算, send: function, command: '计算器.lua', option: "%1$s"}
  LuaNum1: {label: 转大写, send: function, command: '计算器.lua', option: "<1>%1$s"}

向该方案任意按键加入上述按键既可，推荐在数字键盘中加入


第③步 在输入方案中配置，使其支持1-9（）+-*/等计算字符在候选中显示
以 XXX.schema.yaml主题方案为例
说明: 找到recognizer节点，设置以/字符开头，后面可接任意字符，以便在候选中生成计算表达式

recognizer:
  patterns:
    punct: "^/.+$"


]]





--数字转中文大写,增强Format函数，计算到角分
function Format1(szNum) 
local hzNum = {"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"} 

local num1,num2 = math.modf(szNum);
local num3,num4 = math.modf(szNum*10);  --math.modf取小数部分有偏差，慎用
local num5,num6 = math.modf(szNum*100); 
num2=num3-num1*10
num3=num5-num3*10
local text=Format(num1).."圆"
if num2==0 then text=text.."整" 
else
  text=text..hzNum[num2+1].."角" 
  if num3~=0 then text=text..hzNum[num3+1].."分"  end
end

return text
end

--数字转中文大写,只能计算整数
function  Format(szNum)
    local szChMoney = ""
    local iLen = 0
    local iNum = 0
    local iAddZero = 0
    local hzUnit = {"", "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "万", "拾", "佰", "仟"} 
local hzNum = {"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"} 
    if nil == tonumber(szNum) then
        return tostring(szNum)
    end
    iLen =string.len(szNum)
    if iLen > 10 or iLen == 0 or tonumber(szNum) < 0 then
        return tostring(szNum)
    end
    for i = 1, iLen  do
        iNum = string.sub(szNum,i,i)
        if iNum == 0 and i ~= iLen then
            iAddZero = iAddZero + 1
        else
            if iAddZero > 0 then
            szChMoney = szChMoney..hzNum[1]
        end
            szChMoney = szChMoney..hzNum[iNum + 1] --//转换为相应的数字
            iAddZero = 0
        end
        if (iAddZero < 4) and (0 == (iLen - i) % 4 or 0 ~= tonumber(iNum)) then
            szChMoney = szChMoney..hzUnit[iLen-i+1]
        end
    end
--用于记录，需要删除的0
    local msg = {}
--删除目标0
    local function removeDestZero(num,msg)
        num = tostring(num)
        local inNum = num
        local szlen = string.len(num)
        for k,v in ipairs(msg) do
            szlen = string.len(inNum)
            inNum = string.sub(inNum,1,(v-(k-1)*3-1))..string.sub(inNum,(v-(k-1)*3+3),szlen)
        end
        return inNum
    end
--删除尾部0
    local function removeLastZero(num)
        msg = {}
        num = tostring(num)
        local szLen = string.len(num)
        local zero_num = 0
        for i = szLen, 1, -3 do
            szNum = string.sub(num,i-2,i)
            if szNum == hzNum[1] and i == szLen then
                table.insert( msg, i-2)
            elseif szNum == "万" or szNum == "亿" then
                local inNum = string.sub(num,i-5,i-3)
                if inNum == hzNum[1] then
                    table.insert( msg,i-5)
                end
            end
        end
        return msg
    end
--删除中间的0
    local function removeZero(num)
        msg = {}
        num = tostring(num)
        local szLen = string.len(num)
        local zero_num = 0
        for i = 1,szLen,3 do
            szNum = string.sub(num,i,i+2)
            local index = (i+2)/3
            if szNum == hzNum[1] then
                local ret = false
                for k = i+3,szLen,3 do
                    local inNum = string.sub(num,k,k+2)
                    if szNum == inNum then
                        ret = true
                        break
                    elseif  inNum ~= "拾" and inNum ~= "佰" and inNum ~= "仟" and inNum ~= "万" and inNum ~= "亿" then
                        break
                    end
                    
                end
                if ret then
                    table.insert(msg,i)
                end
            end
        end
        if next(msg) then
             num = removeDestZero(num,msg)
        end
        msg = removeLastZero(num)
        if next(msg) then
             num = removeDestZero(num,msg)
        end
        return num
    end
    return removeZero(szChMoney)
end



require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"

local 候选 = (...)



if string.sub(候选,1,1)=="<" and string.sub(候选,3,3)==">" then
  if string.sub(候选,2,2)=="1" then
    候选=string.sub(候选,5)
    local num = tonumber(候选);
    if num then
     -- 得到数字，转换为中文大写
        候选=Format1(tonumber(候选))
     else
      -- 转数字失败,当成计算表达式计算，并转换成中文大写
           候选=loadstring("return "..候选)()
           候选=Format1(tonumber(候选))
       end
    end
else
  候选=string.sub(候选,2)
  
  候选=loadstring("return "..候选)()
--  if loadstring("return "..候选)()==nil then Toast.makeText(service, "非法表达式",Toast.LENGTH_SHORT).show() end
end

--调用同文esc按键关闭候选窗口
service.sendEvent("Escape")

return 候选.."\n"






