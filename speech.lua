--[[
--无障碍版语音专用脚本
--用途：启动语音时同时启动该脚本，为语音功能增加脚本功能
使用说明: 通过语音关键字启动相关功能
为了保证效果，可能一个功能对应多个关键字，一般为近义词
请以识别效果最佳的关键字作为启动命令，可自行添加修改
--------------------
2020-02-08
目前已新增以下功能
1.语音转为功能按键
2.获取网络内容
3.语音内容转为悬浮窗口候选并拆分
]]


require "import"
import "android.widget.*"
import "android.view.*"
import "cjson"
import "android.content.Context" 


--------------------
--功能函数命令

function 一维数组合并(x,y)
    array_3={}
    a=0
    for i = 1,#x+#y -- 合并数组
    do
        if i < #x+1
        then
            array_3[i]=x[i]
        else
            a=a+1
            array_3[i]=y[a]
        end
    end
    return array_3
end



--字符串操作
--返回当前字符实际占用的字符数
local function SubStringGetByteCount(str, index)
    local curByte = string.byte(str, index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte >= 192 and curByte <= 223 then
        byteCount = 2
    elseif curByte >= 224 and curByte <= 239 then
        byteCount = 3
    elseif curByte >= 240 and curByte <= 247 then
        byteCount = 4
    end
    return byteCount;
end 


--获取中英混合UTF8字符串的真实字符数量
local function 中英字符串长度(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

--获取字符串的真实索引值
function SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end



--截取中英混合的UTF8字符串，endIndex可缺省
function SubStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = 中英字符串长度(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = 中英字符串长度(str) + endIndex + 1;
    end

    if endIndex == nil then
        return string.sub(str, SubStringGetTrueIndex(str, startIndex));
    else
        return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end

function 单字98编码(单字)
   local 文件=tostring(service.getLuaExtDir("data")).."/数据包/wubi98编码.txt"
    for 行内容 in io.lines(文件) do
     if string.find(行内容,"^"..单字) != nil && #行内容>0 then 
      return 行内容
     end 
    end
 return ""
end

function 单字86编码(单字)
   local 文件=tostring(service.getLuaExtDir("data")).."/数据包/wubi86编码.txt"
    for 行内容 in io.lines(文件) do
     if string.find(行内容,"^"..单字) != nil && #行内容>0 then 
      return 行内容
     end 
    end
 return ""
end


function 单字拆分(候选内容)
   local 单字组={}
   local 返回内容组={}
   local 中英字符串长=中英字符串长度(候选内容)
   local 内容98编码=""
   local 内容86编码=""
   for i=1, 中英字符串长 do
    单字组[i]=SubStringUTF8(候选内容,i,i)
    内容98编码=内容98编码..单字98编码(单字组[i])
    内容86编码=内容86编码..单字86编码(单字组[i])
   end

    返回内容组=单字组
    返回内容组[#返回内容组+1]=内容98编码.."【98编码】"
    返回内容组[#返回内容组+1]=内容86编码.."【86编码】"
    return 返回内容组
end

--------------------
--语音内容处理

a=(...)

-- if #a >0 then Toast.makeText(service, "语音内容己获取",Toast.LENGTH_SHORT).show() end


if a == "全选并复制。" or a == "全选并复制" or a=="全部选择并复制" or a=="全部选择并复制。" then 
  Toast.makeText(service,"执行 全选并复制 命令",2000).show()
  service.sendEvent("Select_all")
  --Select_all: {label: '☑', send: Control+a}
  service.sendEvent("Copy")
  --Copy: {label: '❐', send: Control+c}  #复制
  a=""
end

if a=="全部选择并删除。" or a=="全部选择并删除" or a=="全选并删除" or a=="全选并删除。" then 
  Toast.makeText(service,"执行 全选并删除 命令",2000).show()
  service.sendEvent("{Control+a}{BackSpace}{Control+v}")
  
  --service.sendEvent("Select_all")
  --Select_all: {label: '☑', send: Control+a}
  --service.sendEvent("BackSpace")
  --BackSpace: {label: ⌫, repeatable: true, send: BackSpace} #退格
  a=""
end



if a == "随机笑话。" or a == "随机笑话" then 
  a=""
  有网络=true
   Http.get("http://www.mxnzp.com/api/jokes/list/random",function(c1,t1)
    if string.find(t1,"Unable to resolve")==1 then 
   Toast.makeText(service, "内容无法获取，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
   if 有网络 then
    d=cjson.decode(t1).data
    if d~=nil then service.commitText(d[1]["content"] ) end
   end
  end)

end

if a == "随机诗词。" or a == "随机诗词" then 
  a=""
  有网络=true
   Http.get("https://api.gushi.ci/all.json",function(c1,t1)
    if string.find(t1,"Unable to resolve")==1 then 
   Toast.makeText(service, "内容无法获取，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
   if 有网络 then
    d=cjson.decode(t1)
    if d~=nil then service.commitText(d.content) end
   end
  end)
end

if a == "随机诗词完整版。" or a == "随机诗词完整版" then 
  a=""
  有网络=true
   Http.get("https://api.gushi.ci/all.json",function(c1,t1)
    if string.find(t1,"Unable to resolve")==1 then 
   Toast.makeText(service, "内容无法获取，请检查网络",Toast.LENGTH_SHORT).show() 
    有网络=false
    end
   if 有网络 then
    d=cjson.decode(t1)
    if d~=nil then 
      上屏内容=string.format("诗句: %s\n诗名: %s 作者: %s",d.content,d.origin,d.author)
      service.commitText(上屏内容)
     end
   end
  end)
end


-- if #a >0 then return a end



---[[
if #a >0 then 
 
 service.sendEvent("hlsz") --运行功能按键,显示悬浮窗口
  语音内容组={}
  语音内容组[1]=a
  单字组=单字拆分(a)
  内容组={}
  内容组=一维数组合并(语音内容组,单字组)
  service.addCompositions(内容组)
end

--]]



