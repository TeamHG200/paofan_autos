local t = ff:home({
          since_id = args["since_id"]
          })

local tl = json.decode(t)

if #tl > 0 then

    for i=1,#tl do
        local status = tl[1]    
        if status["text"] == "晚安" then
            ff:post({
                status = "@"..status["user"]["name"].." 晚安",
                reply_id = status["id"]
            })
        end
    end

    args["since_id"] = tl[1]["id"]
end
