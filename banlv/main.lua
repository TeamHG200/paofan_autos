-- 从上一次的消息开始，获取当前所有的新消息
local t = ff:home({
          since_id = args["since_id"]
          })

-- 把JSON消息转化为TABLE结构
local tl = json.decode(t)

-- 如果用户有新消息，则返回结果大于0
if #tl > 0 then

    -- 给每一个说晚安的人回复晚安
    for i=1,#tl do
        local status = tl[1]    
        if status["text"] == "晚安" then
            ff:post({
                status = "@"..status["user"]["name"].." 晚安",
                reply_id = status["id"]
            })
        end
    end

    -- 同时记录下关注的用户最新的一条消息id
    args["since_id"] = tl[1]["id"]
end
