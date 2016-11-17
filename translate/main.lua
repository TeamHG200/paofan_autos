-- get user new message since last message
local t = ff:timeline({
        user_id = args["user_id"],
        since_id = args["since_id"]
        })

local tl = json.decode(t)
local url = "fanyi.youdao.com/openapi.do?keyfrom=paofan-translat&key=523648783&type=data&doctype=json&version=1.1&q="
-- if user has new message
if #tl > 0 then
    for i=#tl,1,-1 do
        if string.find(tl[i]["text"],"#trans#") then
            local text = string.gsub(tl[i]["text"], "#trans#", "")
            local res = ff:curl({
                url = url..db:encode(text)
            })

            local r = json.decode(res)

            ff:del({
                id = tl[i]["id"]
            })

            ff:post({
                status = "#泡饭翻译机器人#\r"..text.."\r"..r["translation"][1]
            })

        end
    end
    args["since_id"] = tl[1]["id"]
end
