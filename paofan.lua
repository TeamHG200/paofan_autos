package.cpath="/root/paofan_server/paofan/libpaofan.so"
package.path="/root/paofan_server/paofan/?.lua;/root/paofan/www/auto/?.lua"
local paofan  = require("paofan")
json = require("json")

pf_ff = FF()
ff = FF()
db = DB()
args = {}

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

function main(q)

    local res = {enable="false"}
    if q["action"] == "do_info" then
        res = db:getUserInfo(q)

    elseif q["action"] == "push" then
        local m = db:apns({
           user_id = q["user_id"],
           content = q["message"]
        })

        if m["success"] == "true" then        
           res = {enable = "true"}
        else
           res = {enable = "false"}
        end
    elseif q["action"] == "is_push_on" then
        res = db:isPushOn(q)

    elseif q["action"] == "is_enable" then
        res = db:isEnable(q)

    elseif q["action"] == "set_user" then
        res = db:setEnable(q)

    elseif q["action"] == "set_script" then
        q["args"] = json.encode(q)
        res = db:setScript(q)

    elseif q["action"] == "get_script" then
        r = db:getScript(q)
        if r["args"] then
            res = json.decode(r["args"])
        end

    elseif q["action"] == "set_remark" then
        res = db:setRemark(q)

    elseif q["action"] == "get_remark" then
        res = db:getRemark(q)
    
    elseif q["action"] == "get_script_info" then
        res = db:getScriptInfo(q)
        res["enable"] = "true"

    elseif q["action"] == "exe_script" then
        local verify = db:getVerifyInfo(q)
        ff:init(verify)
        res = db:getScript(q)
        if res["enable"] == "true" then
            args = json.decode(res["args"])
            require(res["script"])
            res["args"] = json.encode(args)
            res["enable"] = args["enable"] or res["enable"]
            db:setScript(res)
        end
    end

    return res 
end
