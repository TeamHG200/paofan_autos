-- get user new message since last message
if args["target_user"] ~= "target_user" then

local t = ff:timeline({
        user_id = args["target_user"], 
        since_id = args["since_id"]
        })

local tl = json.decode(t)

-- if user has new message
if #tl > 0 then
    
    -- send a push to self
    db:apns({
            user_id = args["user_id"], 
            content = "狗蛋说:" .. tl[1]["text"]
            })

    -- save the new message 
    args["since_id"] = tl[1]["id"]
end

end
