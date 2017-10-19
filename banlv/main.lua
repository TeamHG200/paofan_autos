local math = require("math")
local t = ff:home({
          since_id = args["since_id"]
          })

local tl = json.decode(t)

local reply = {
    "晚安~",
    "晚安呗",
    "good night >_<",
    "早点休息",
    "盖好被子",
    "沉睡吧！蠢货！",
    "好梦"
}

if #tl > 0 then

    for i=1,#tl do
        local status = tl[1]    
        if string.find(status["text"], "晚安") == 1
        and status["user"]["id"] ~= args["user_id"]
        and status["user"]["id"] ~= 'TestByTse' then
            ff:post({
                status = "@"..status["user"]["name"].." "..reply[math.random(#reply)] .. "\n#泡饭晚安机器人#",
                reply_id = status["id"]
            })
        end
    end

    args["since_id"] = tl[1]["id"]
end
