--[[
--无障碍版专用脚本
--脚本名称: 输入法信息
--用途：上屏输入法相关信息，
--版本号: 1.0
▂▂▂▂▂▂▂▂
日期: 2020年04月07日🗓️
农历: 鼠(庚子)年三月十五
时间: 21:37:04🕤
星期: 周二
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)

--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 输入法信息.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键

preset_keys:
  lua_AppInfo1: {label: 🐝, send: function, command: '输入法信息.lua', option: ""} #悬浮窗口显示
  lua_AppInfo2: {label: 🐝, send: function, command: '输入法信息.lua', option: "1"} #直接上屏


向该方案任意按键加入上述按键既可
]]

require "import"

function 应用信息(包名)
  import "android.content.pm.PackageManager"
  local pm = service.getPackageManager();
  local 图标 = pm.getApplicationInfo(tostring(包名),0)
  local 图标 = 图标.loadIcon(pm);
  local pkg = service.getPackageManager().getPackageInfo(包名, 0); 
  local 应用名称 = pkg.applicationInfo.loadLabel(service.getPackageManager())
  local 版本号 = service.getPackageManager().getPackageInfo(包名, 0).versionName
  local 最后更新时间 = service.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
  local cal = Calendar.getInstance();
  cal.setTimeInMillis(最后更新时间); 
  local 最后更新时间 = cal.getTime().toLocaleString()
  return 包名,版本号,最后更新时间,图标,应用名称
end


import "com.osfans.trime.*"
local a=Rime.getSchemaId() --方案id
local b=Rime.getSchemaName() --方案名称
local c=Rime.get_version() --RIME版本号
local d=Rime.get_librime_version() --RIME版本完整信息
local e=Rime.get_opencc_version() --OpenCC版本
local f=Rime.get_trime_version() --Trime版本
local g=Rime.get_shared_data_dir() --共享文件夹路径
local h=Rime.get_user_data_dir() --用户文件夹路径
local i=Rime.get_sync_dir() --同步文件夹路径
local j=Rime.get_user_id() --同步文件夹id路径

local device_model = Build.MODEL --设备型号 
local version_sdk = Build.VERSION.SDK --设备SDK版本 
local version_release = Build.VERSION.RELEASE --设备的系统版本

local app=service.getPackageName()  --本应用包名

local 包名,版本号,最后更新时间,图标,应用名称=应用信息(service.getPackageName())


local 上屏文字="✏✏✏✏✏✏✏✏✏✏\n以上内容来自: \n📟"..应用名称.."\n🖌包名: "..包名.."\n🖍版本号: "..版本号.."\n🖊方案id: "..a.."\n🖋方案名称: "..tostring(b).."\n✒RIME版本号: "..d.."\n⌨OpenCC版本: "..e.."\n📄Trime版本: "..f.."\n📱设备型号: "..device_model.."\n🚪设备SDK版本: "..version_sdk.."\n🎴设备系统版本: "..version_release

local 参数 = (...)
if 参数=="1" then 
 service.commitText(上屏文字)
else
 service.addCompositions({上屏文字})
end


