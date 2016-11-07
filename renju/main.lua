local seg = {
    "真是一步好棋",
    "喔吼吼，看我这一棋精不精秒",
    "呀嘞嘞，有两下子嘛",
    "愚蠢的法师，小心玩火自焚",
    "若水都比你下得好！",
    "你这样等于自寻死路",
    "呵呵，打得不错",
    "将军！啊不，连珠！"
}


local pending_user = args["pending_user"]
local target_user = args["target_user"]
local target_name = args["target_name"]
local last_msg = args["last_msg"]
local del_msg = args["del_msg"]
local user_id = args["user_id"]

if target_user then 
local file = "/tmp/"..user_id.."."..target_user..".jpg"
local gm = GM()

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

local step = split_str(args["step"], ",")
 
function teardown(tl) 
     local all_step = table.concat(step, ",")
     gm:drawRenju(file, step)
     local winner = gm:chisRenju(step)
     ff:del({
           id = del_msg
     })

     local r = {}
     if winner == "" then
       r = ff:post({
           status = "#renju# 正在与@"..target_name.." 对战 "..seg[(#step)%(#seg)+1].."("..all_step..")",
           photo = file
       })
     else
       local win = winner == "B" and "战败！" or "获胜！"
       r = ff:post({
           status = "#renju# @"..target_name.." "..win.." ".."("..all_step..")",
           photo = file
       })
       args["enable"] = "false"
     end

     local res = json.decode(r)
     args["del_msg"] = res["id"]
     args["last_msg"] = tl["id"]
     args["step"] = all_step
     args["pending_user"] = pending_user == user_id and target_user or user_id
     db:apns({
         user_id = pending_user,
         content = "该你出棋了"
     })
end

if pending_user then

    local t = ff:timeline({
            user_id = pending_user
    })

    local tl = json.decode(t)
    if #tl > 0 then
        local is_post = false
        for i=1,#tl do
            if tl[i]["in_reply_to_status_id"] == last_msg then
                local pos1,pos2 = string.find(tl[i]["text"],"%d+")
                if pos1 and pos2 and not is_post then
                    is_post =true

                    local s = string.sub(tl[i]["text"], pos1, pos2)
                    local all_step = table.concat(step, ",")

                    if string.find(all_step, s) ~= nil or tonumber(s) > 100 then
                      local r = ff:post({
                         status = "#renju# 走错了，该子已存在或落子在棋盘外"
                      })
                    else
                      local text = ((pending_user == user_id) and "B" or "W") ..s                
                      table.insert(step, text)
                    end
                    teardown(tl[i])
                end
            end
        end
    end
else
    table.insert(step, "B55")
    gm:drawRenju(file, step)
    args["step"] = table.concat(step, ",")
    if target_user == "AI" then
        local t = ff:post({
            status = "#renju# 来吧，让我们大干一场！ @AI",
            photo = file
        })

        local tl = json.decode(t)
        args["last_msg"] = tl["id"]
        args["pending_user"] = target_user
        args["target_name"] = "sillychis" 

    else
        local r = ff:timeline({
            user_id = target_user
        })
        local res = json.decode(r)
        local name = res[1]["user"]["name"]

        local t = ff:post({
            status = "#renju# 来吧，让我们大干一场！ @"..name,
            photo = file
        })

        local tl = json.decode(t)
        args["last_msg"] = tl["id"]
        args["pending_user"] = target_user
        args["target_name"] = name 
        db:apns({
            user_id = target_user,
            content = user_id .. "邀请你来一场五子棋大战！"
        })
    end
end

end
