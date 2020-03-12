--[[
--无障碍版专用脚本
--用途：欧路词典，自动打开欧路词典(若存在)查词界面，查询候选内容


--配置说明
第①步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键shareWX

preset_keys:
  shareQL: {label: 欧陆, send: function, command: '欧路词典.lua', option: "%1$s"}

向该方案任意按键加入上述按键既可

]]



local 导入内容 = (...)
require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.*"



--分享文字到欧路
text=导入内容
intent=Intent(Intent.ACTION_SEND); 
intent.setType("text/plain"); 
intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
intent.putExtra(Intent.EXTRA_TEXT, text); 
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
--重点，指定包名和分享界面
componentName =ComponentName("com.eusoft.eudic","com.eusoft.dict.activity.dict.LightpeekActivity");
intent.setComponent(componentName)

service.startActivity(Intent.createChooser(intent,"分享到:")); 


