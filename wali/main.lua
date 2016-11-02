local time = os.time()
local commit_time = args["commit_time"]
local expire_time = args["expire_time"]
local status = args["status"]
if time > commit_time + expire_time then

    ff:post({
        status = args["status"]
    })

    args["commit_time"] = time

end
