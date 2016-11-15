module("sillycap", package.seeall)
local B = require("bod")
local S = require("score")
local P = require("plan")
P.MAX_DEEP = 3

function capRenjuNext(step)

   print(step[1])
   local bod = {}
   for i=1,#step do
      local x = string.sub(step[i],2,2)
      local y = string.sub(step[i],3,3)
      table.insert(bod, {tonumber(x+1), tonumber(y+1)})
   end

   B.show_bod(bod,10)

   local s,n = P.alphabeta(bod, 10, 1, S.MAX_SCORE, -S.MAX_SCORE)
   return tostring(n[1]-1)..tostring(n[2]-1)

end
