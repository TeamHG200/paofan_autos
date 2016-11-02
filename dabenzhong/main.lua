local time = tonumber(string.format("%d",os.time()/3600%24+8))

local count = tonumber(args["local_time"]) or 0
count = count % 24
if time > count then

    local str = ""
    for i=1,time do str = str.." guang!" end

    ff:post({ status = str })

    args["local_time"] =  tostring(time)

end
