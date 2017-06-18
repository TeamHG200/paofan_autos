local math = require("math")
local t = ff:home({
          since_id = args["since_id"]
          })

local tl = json.decode(t)

local reply = {
    "晚安~",
    "good night >_<",
    "早点休息",
    "好梦"
}

if #tl > 0 then

    for i=1,#tl do
        local status = tl[1]    
        if string.find(status["text"], "晚安") == 1
        and status["user"]["id"] ~= args["user_id"] then
            ff:post({
                status = "@"..status["user"]["name"]..reply(math.random(4)),
                status = status + "\n#泡饭关爱机器人#"
                reply_id = status["id"]
            })
        end
    end

    args["since_id"] = tl[1]["id"]
end
