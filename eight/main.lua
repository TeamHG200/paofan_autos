-- get user new message since last message
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


if args["keyword"] ~= "keyword" and args["keyword"] ~= "" then

    local targets = split_str(args["keyword"], "|")
    local since_ids = split_str(args["since_id"], "|")

    for i=1,#targets do

        local t = ff:home({
                  since_id = since_ids[i] or ""
                  })

        local tl = json.decode(t)

        -- if user has new message
        if #tl > 0 then

            if string.find(tl[1]["text"], targets[i]) ~= nil then
            
            -- send a push to self
                db:apns({
                  user_id = args["user_id"], 
                  content = "里亚尔[" .. targets[i] .. "]:" .. tl[1]["text"]
                })

            end 
            -- save the new message 
            since_ids[i] = tl[1]["id"]

        end


    end 

    args["since_id"] = table.concat(since_ids,"|")

end
