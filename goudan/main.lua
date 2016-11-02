-- 从上一次的消息开始，获取用户的新消息
local t = ff:timeline({
        user_id = args["target_user"],  -- 关注用户的id
        since_id = args["since_id"]     -- 关注用户上次的最新消息
        })

-- 把JSON消息转化为TABLE结构
local tl = json.decode(t)

-- 如果用户有新消息，则返回结果大于0
if #tl > 0 then
    
    -- 给自己发送一个推送通知
    db:apns({
            user_id = args["user_id"], 
            content = "狗蛋蹭了蹭你，并对你说有新消息啦！"
            })

    -- 同时记录下关注的用户最新的一条消息id
    args["since_id"] = tl[1]["id"]
end
