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

local gm = GM()
local t = ff:reply({
        user_id = args["user_id"]
    })
local replyed_msg = {}
local tl = json.decode(t)
for i=#tl,1,-1 do
    local msg = tl[i]
    local msg_id = tl[i]["id"]
    local rep_id = tl[i]["in_reply_to_status_id"]
    local target_user_id = msg["user"]["id"]
    local target_user_name = msg["user"]["name"]

    local script = db:getScript({
        script_id = target_user_id.."-6"
    })    

    print(rep_id)
    if script and script["args"] then
        local t_args = json.decode(script["args"])
        local step = split_str(t_args["step"],",")
        if t_args["pending_user"] == args["user_id"] and 
           t_args["last_msg"] == msg_id and
           (rep_id == "" or replyed_msg[rep_id] == nil) and
           script["enable"] == "true" then
            local res = gm:chisRenjuNext(step)
            ff:post({
                status = "@"..target_user_name.." "..res,
                reply_id = msg_id
           })
           args["last_msg"] = msg_id
        end
    end
    replyed_msg[rep_id] = true
end

if #tl > 0 then
    args["since_id"] = tl[1]["id"]
end
