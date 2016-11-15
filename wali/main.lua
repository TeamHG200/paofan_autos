function split_str(str, token)
    local list = {}
    if str == nil or str == "" then
        return {""}
    end
    local pattern = string.format('[^%s]+', token)
    for value in string.gmatch(str, pattern) do
        table.insert(list, value)
    end
    return list
end

local time = os.time()
local c_week = tostring(tonumber(os.date("%w", time)))
local c_month = tostring(tonumber(os.date("%m", time)))
local c_day = tostring(tonumber(os.date("%d", time)))
local c_hour = tostring(tonumber(os.date("%H", time)))
local c_minutes = tostring(tonumber(os.date("%M", time)))

local trigger = 
{false, false, false, false }
--week   month  day    hour   minutes

local week = split_str(args["week"],",")
local day = split_str(args["day"],",")
local hour = split_str(args["hour"],",")
local minutes = split_str(args["minutes"],",")
               
function is_trigger(list, c, index)
    for i=1,#list do
        if c == list[i] or list[i] == "" then
           trigger[index] = true
        end
    end
end

is_trigger(week, c_week, 1)
is_trigger(day, c_day, 2)
is_trigger(hour, c_hour, 3)
is_trigger(minutes, c_minutes, 4)

print(trigger[1],trigger[2],trigger[3],trigger[4])
if trigger[1] and trigger[2] and trigger[3] and trigger[4]  then
    
    ff:post({
        status = args["status"]
    })

    db:apns({
        user_id = args["user_id"],
        content = args["status"]
    })

end
