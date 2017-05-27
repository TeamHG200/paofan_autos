function split_str(str, token)
    local list = {}
    if str == nil then
        return list
    end
    local pattern = string.format('[^%s]+', token)
    for value in string.gmatch(str, pattern) do
        table.insert(list, value)
    end
    return list
end

if tonumber(os.date("%M", time))%5 == 0 then

local follow = {}
local user_id = args["user_id"]
local count = "50"
local page = 1
local max_count = 3
local current_follow = {}

local res = ff:follower({
                user_id = user_id,
                page = tostring(page),
                count = count
            })

local tl = json.decode(res)

while #tl > 0 do
    for t=1,#tl do
        table.insert(current_follow, tl[t]["id"])
    end
    page = page+1
    if page > max_count then break end
    res = ff:follower({
                user_id = user_id,
                page = tostring(page),
                count = count
              })
    tl = json.decode(res)
end

if args["follow"] ~= nil then
    follow = split_str(args["follow"], ",")
end

for i=1,#follow do
    local isfo = false
    for j=1,#current_follow do
        if follow[i] == current_follow[j] then
            isfo = true
            break
        end
    end

    if isfo == false then
        local verify = db:getVerifyInfo({
            user_id = "paofan"
        })
        local pf = FF()
        pf:init(verify)

        pf:message({
            user_id = user_id,
            content = follow[i].." 取消关注了你"
        })

        db:apns({
            user_id = user_id,
            content = "臭臭:"..follow[i].." 取消关注了你"
        })
    end
end

args["follow"] = table.concat(current_follow,",")

end
