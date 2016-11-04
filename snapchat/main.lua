-- get user new message since last message
local t = ff:timeline({
        user_id = args["user_id"]
        })

local tl = json.decode(t)
local expire_time = 600
-- if user has new message
if #tl > 0 then
    for i=#tl,1,-1 do
        if string.find(tl[i]["text"],"#snap#") then
            local id = tl[i]["id"]
            if args[id] == nil then
                args[id] = tostring(expire_time)
            end

            local exp = tonumber(args[id])
            if exp > 0 then
                exp = exp - 30
                args[id] = tostring(exp)
            else
                args[id] = nil
                ff:del({
                    ["id"] = id
                })
                db:apns({
                    user_id = args["user_id"], 
                    content = "已删除:" .. tl[i]["text"]
                })
            end    
        end
    end
end
