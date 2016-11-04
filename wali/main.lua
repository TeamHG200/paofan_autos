local time = os.time()
if args["origin_expire_time"] == nil then
    args["origin_expire_time"] = args["expire_time"]
end
local expire_time = tonumber(args["expire_time"])
local loop_count = tonumber(args["loop_count"])
local status = args["status"]
if expire_time > 0 and loop_count > 0 then

    expire_time = expire_time - 30
    args["expire_time"] = tostring(expire_time)

elseif expire_time > -100 and loop_count > 0 then

    ff:post({
        status = args["status"]
    })

    loop_count = loop_count - 1
    args["expire_time"] = args["origin_expire_time"]
    args["loop_count"] = tostring(loop_count)

    if loop_count == 0 then
        args["origin_expire_time"] = nil
        args["enable"] = "false"
    end


end
