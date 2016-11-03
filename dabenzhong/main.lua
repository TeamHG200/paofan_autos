local time = tonumber(string.format("%d",os.time()/3600%24+8))%24
local count = (tonumber(args["local_time"]) or 0)%24
local status = args["status"] or " guang!"
if time ~= count then
    local str = ""
    for i=1,time do str = str..status end
    ff:post({ status = str })
    args["local_time"] =  tostring(time)
end
