local math = require("math")
local t = ff:home({
          since_id = args["since_id"]
          })

local tl = json.decode(t)

local reply = {
    "晚安~",
    "good night >_<",
    "早点休息",
    "盖好被子",
    "在上个厕所要不",
    "好梦"
}

if #tl > 0 then

    for i=1,#tl do
        local status = tl[1]    
        if string.find(status["text"], "晚安") == 1
        and status["user"]["id"] ~= args["user_id"]
        and status["user"]["id"] ~= 'TestByTse' then
            ff:post({
                status = "@"..status["user"]["name"].." "..reply[math.random(6)] .. "\n#泡饭晚安机器人#",
                reply_id = status["id"]
            })
        end
    end

    args["since_id"] = tl[1]["id"]
end
