-- get user new message since last message
local t = ff:timeline({
        user_id = args["user_id"],
        since_id = args["since_id"]
        })

local tl = json.decode(t)
-- if user has new message
if #tl > 0 then
    for i=#tl,1,-1 do
        if string.find(tl[i]["text"],"#cal#") then
            local text = string.gsub(tl[i]["text"], "#cal#", "")

            pcall(loadstring('a='..text))

            ff:del({
                id = tl[i]["id"]
            })

            ff:post({
                status = "#泡饭算术机器人#\r"..text.."="..tostring(a)
            })

        end
    end
    args["since_id"] = tl[1]["id"]
end
