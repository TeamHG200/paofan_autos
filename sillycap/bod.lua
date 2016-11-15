module("bod", package.seeall)

function show_bod(bod, count)

   bod.index = {}
   for i=1,#bod do
      -- true is first, false if second
      bod.index[bod[i][1]*100+bod[i][2]] = (i%2 == 1)
   end

   for j=1,count do
      local line = {}
      for i=1,count do
         if bod.index[i*100+j] == true then
            table.insert(line, "o")
         elseif bod.index[i*100+j] == false then
            table.insert(line, "+")
         else
            table.insert(line, ".")
         end
      end
      print(table.concat(line, " "))
   end
end

function has_neghbor(index, point)
   return (index[(point[1]-1)*100+point[2]] ~= nil)
      or (index[(point[1]+1)*100+point[2]] ~= nil)
      or (index[(point[1])*100+point[2]+1] ~= nil)
      or (index[(point[1])*100+point[2]-1] ~= nil)
      or (index[(point[1]-1)*100+point[2]-1] ~= nil)
      or (index[(point[1]+1)*100+point[2]+1] ~= nil)
      or (index[(point[1]-1)*100+point[2]+1] ~= nil)
      or (index[(point[1]+1)*100+point[2]-1] ~= nil)
end

-- returne all point can be droped
function generate(index, count)

   local list = {}
   for i=1,count do
      for j=1,count do
         if index[i*100+j] == nil then
            if has_neghbor(index, {i,j}) then
               table.insert(list, {i,j})
            end
         end
      end
   end
   return list
end

function show_step(bod)
   local steps = {}
   for i=1,#bod do
      table.insert(steps, bod[i][1]*100+bod[i][2])
   end
   return table.concat(steps,",")
end
