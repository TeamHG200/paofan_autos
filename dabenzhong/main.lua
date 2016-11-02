
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
