module("score", package.seeall)
MAX_SCORE = 10000000000
local SCORE_META = {
    ["H5"] = MAX_SCORE,
    ["D5"] = MAX_SCORE,
    ["H4"] = 10000000,
    ["D4"] = 10000,
    ["H3"] = 10000,
    ["D3"] = 1000,
    ["H2"] = 1000,
    ["D2"] = 100,
    ["H1"] = 100,
    ["D1"] = 10
}

-- score a flat line and return status
function score_flat(line)

    local score= {}
    local combo = 0
    local dh = "D"

    for i=1,#line do
        if line[i] == 1 then
            combo = combo+1
        elseif line[i] == 2 then
            dh = "D"
            if combo > 0 then
                if combo > 5 then combo = 5 end
                table.insert(score, dh..tostring(combo))
                combo = 0
            end
        elseif line[i] == 0 then
            if combo > 0 then
                if combo > 5 then combo = 5 end
                table.insert(score, dh..tostring(combo))
                combo = 0
            end
            dh = "H"
        end
    end
    return score
end

function make_flat(index, points, is_black)
   local line = {2}
   for i=1,#points do
      local key = points[i][1]*100+points[i][2]
      if index[key] == true then
         table.insert(line, is_black and 1 or 2)
      elseif index[key] == false then
         table.insert(line, is_black and 2 or 1)
      else
         table.insert(line, 0)
      end
   end
   table.insert(line, 2)
   return line
end

function prepare_flat(index, count)

   local points_list = {}
   for i=1,count do
      local points = {}
      for j=1,count do
         table.insert(points, {i, j})
      end
      table.insert(points_list,points)
   end

   for i=1,count do
      local points = {}
      for j=1,count do
         table.insert(points, {j, i})
      end
      table.insert(points_list,points)
   end

   for i=1,count do
      local points = {}
      for j=1,i do
         table.insert(points, {i-j+1, j})
      end
      table.insert(points_list,points)

   end

   for i=1,count do
      local points = {}
      for j=1,i do
         table.insert(points, {count-i+j, j})
      end
      table.insert(points_list,points)

   end

   for i=1, count-1 do
      local points = {}
      for j=1, i do
         table.insert(points, {count-i+j, count-j+1})
      end
      table.insert(points_list,points)

   end

   for i=1, count-1 do
      local points = {}
      for j=1, i do
         table.insert(points, {j, count-i+j})
      end
      table.insert(points_list,points)
   end

   return points_list
end

function score_bod(bod, count)

   local final_score_b = 0
   local final_score_w = 0

   -- black final score
   local points_list = prepare_flat(bod.index, count)
   for i=1,#points_list do
      local points = make_flat(bod.index, points_list[i], true)
      local score = score_flat(points)
      for j=1,#score do
         final_score_b = final_score_b + SCORE_META[score[j]]
      end
   end

   -- white final score
   local points_list = prepare_flat(bod.index, count)
   for i=1,#points_list do
      local points = make_flat(bod.index, points_list[i], false)
      local score = score_flat(points)
      for j=1,#score do
         final_score_w = final_score_w - SCORE_META[score[j]]
      end
   end

   return final_score_b+final_score_w

end
