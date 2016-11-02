## 泡饭机器人计划

> 泡饭机器人是用户自主开发的脚本， 可以通过ios客户端PaoFan来远程打开，关闭和设置。泡饭服务器对饭否API做了精简抽象，提供了精简的脚本实现来完成众多稀奇古怪的应用，并提供给广大饭否用户使用。

### API简介

| 方法名 | 参数 | 返回 | 含义 |
| ----- | ---- | --- | --- |
| ff:post | table | 无 | 发送饭否消息 |
| ff:timeline | table | table | 获取指定账号的时间线 | 
| db:apns | table | 无 | 给指定账号发送一条推送 | 

#### 示例

* 实现一个大笨钟


~~~

-- 获取格林尼治时间的小时然后加上时区 +8
local time = string.format("%0.0f",os.time()/3600)%24+8

-- 获取上次咣的次数，如果上次没有咣过，那就是0
local count = tonumber(args["local_time"]) or 0

-- 如果当前时间大于上次咣的时间，那就要开始咣了
if time > count then

    -- 生成咣的字符串，如果当前时间是8点，就要咣8次
    local str = ""
    for i=1,time do str = str.." guang!" end

    -- 发送饭否，当前账号
    ff:post({ status = str })

    -- 保存这次咣的次数，下次参与计算，避免重复咣
    args["local_time"] =  tostring(time)

end

~~
