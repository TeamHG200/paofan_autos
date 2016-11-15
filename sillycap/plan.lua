module("plan", package.seeall)
MAX_DEEP = 0
local S = require("score")
local B = require("bod")


function minmax(bod, count, deep)

   if deep == MAX_DEEP then
      return S.score_bod(bod, count),{0,0}
   end

   local best_step = {0,0}
   local is_max = deep%2 == 0
   local is_black = (#bod%2==0)
   local final_score = is_black and -S.MAX_SCORE or S.MAX_SCORE
   local dropable = B.generate(bod.index, count)

   for i=1,#dropable do
      local next_step = dropable[i][1]*100+dropable[i][2]

      -- set step
      bod.index[next_step] = is_black
      table.insert(bod, {dropable[i][1], dropable[i][2]})

      local score,step = minmax(bod, count, deep+1)
      -- print(tostring(score)..":"..tostring(B.show_step(bod)))

      if is_black then -- my turn, find the max
         if score > final_score then
            final_score = score
            best_step = dropable[i]
         end
      else -- your turn, find the min
         if score < final_score then
            final_score = score
            best_step = dropable[i]
         end
      end
      -- reset step
      bod.index[next_step] = nil
      bod[#bod] = nil
   end

   return final_score,best_step

end

function alphabeta(bod, count, deep, alpha, beta)

   if deep == MAX_DEEP then
      return S.score_bod(bod, count),{0,0}
   end

   local best_step = { {0,0} }
   local is_black = (#bod%2==0)
   local final_score = is_black and -S.MAX_SCORE or S.MAX_SCORE
   local dropable = B.generate(bod.index, count)


   for i=1,#dropable do
      local next_step = dropable[i][1]*100+dropable[i][2]

      -- set step
      bod.index[next_step] = is_black
      table.insert(bod, {dropable[i][1], dropable[i][2]})


      local score,step = alphabeta(bod, count, deep+1,
                                   final_score < alpha and final_score or alpha,
                                   final_score > beta and final_score or beta)
      -- print(tostring(score)..":"..tostring(B.show_step(bod)))

      if is_black then -- my turn, find the max
         if score > final_score then
            final_score = score
            best_step = { dropable[i] }
         end
      else -- your turn, find the min
         if score < final_score then
            final_score = score
            best_step = { dropable[i] }
         end
      end

      if score == final_score then
         table.insert(best_step, dropable[i])
      end

      -- reset step
      bod.index[next_step] = nil
      bod[#bod] = nil

      if is_black and final_score >= alpha then
         return final_score,best_step[os.time()%(#best_step)+1]
      elseif not is_black and  final_score <= beta then
         return final_score,best_step[os.time()%(#best_step)+1]
      end

   end

   return final_score,best_step[os.time()%(#best_step)+1]
end
