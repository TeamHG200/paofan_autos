local time = tonumber(string.format("%d",os.time()/3600%24+8))%24
local count = (tonumber(args["local_time"]) or 0)%24
local status = args["status"] or " guang!"

if status == "status" then
    status = "北京时间 %d 点整"
end

local clock = {
    '🕛 ',
    '🕐 ',
    '🕑 ',
    '🕒 ',
    '🕓 ',
    '🕔 ',
    '🕕 ',
    '🕖 ',
    '🕗 ',
    '🕘 ',
    '🕙 ',
    '🕚 ',
}

if time ~= count then
    local str = "#泡饭大笨钟#\r"
    str = str..clock[time%12]
    str = str..string.format(status,time)
    ff:post({ status = str })
    args["local_time"] =  tostring(time)
end
