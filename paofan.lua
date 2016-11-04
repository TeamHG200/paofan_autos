package.cpath="/root/paofan_server/paofan/libpaofan.so"
package.path="/root/paofan_server/paofan/?.lua;/root/paofan/www/auto/?.lua"
local paofan  = require("paofan")
json = require("json")

ff = FF()
db = DB()
args = {}
function main(q)

    local res = {enable="false"}
    if q["action"] == "do_info" then
        res = db:getUserInfo(q)

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
