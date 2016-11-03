local time = os.time()
local expire_time = tonumber(args["expire_time"])
local status = args["status"]
if expire_time > 0 then

    expire_time = expire_time - 30
    args["expire_time"] = tostring(expire_time)

elseif expire_time > -100 then

    ff:post({
        status = args["status"]
    })

    args["expire_time"] = tostring(-1000)

end
