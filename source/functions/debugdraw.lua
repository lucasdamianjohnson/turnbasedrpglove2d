function getDebugDraw()

bugdraw = {}
bugdraw.active = false
bugdraw.following = {} --variable debuug is following
--[[
Add object to follow into debug printing
params
#follow_object -> the object to be followed - lua table
#var_heading -> Heading to display for the print out
#var_follows -> lua table array of value keys to display in the object - array of strings
#var_display -> object value key to check to display in debug - if not set the object will always be shown
#debug_id -> Optional, set a flag to remove from debug list
]]
function bugdraw:addToDebug(follow_object,var_heading,var_follows,var_display,debug_id)
    var_heading = var_heading or "Default"
    var_follows = var_follows or {}
    var_display = var_display or "IGNORE!!"
    debug_id = debug_id or "IGNORE!!"
    newfollow = {
      object = follow_object,
      heading = var_heading,
      variables = var_follows,
      display = var_display,
      debug_id = debug_id
    }
    table.insert(self.following,newfollow)
end

function bugdraw:removeFromDebug(id)

  local num = #self.following

  for i,var in pairs(self.following)  do
    if var.debug_id == id then
          table.remove(self.following,i)
    end
  end

end

function bugdraw:draw()

  if self.active then
    love.graphics.setColor(0, 0, 0, .7)
    xstart = 0
    ystart = 0
    lines = 1
    width = "1870"
    height = "1200"
    love.graphics.rectangle("fill", xstart, ystart, width, height)
    love.graphics.setColor(1, 1,1, 1)

    xspacing = 30
    yspacing = 0
    love.graphics.setFont(fonts.debug)
      for i,follow in ipairs(self.following) do
          if follow.display == "IGNORE!!" or follow.object[follow.display] then
          love.graphics.setColor(0,1,0,1)
          love.graphics.print(follow.heading,xstart + xspacing, ystart + yspacing)
          yspacing = yspacing + 30
          for x,vars in ipairs(follow.variables) do

          love.graphics.setColor(0,0,1,1)
          love.graphics.print(vars,xstart + xspacing, ystart + yspacing)
          love.graphics.setColor(1,0,0,1)

          local display_var = follow.object[vars]
            if display_var == false or display_var == nil then
              display_var = "false"
            elseif type(display_var) == "boolean" and display_var == true then
              display_var = "true"
            end
              love.graphics.print(display_var,xstart + xspacing + 250, ystart + yspacing)
              yspacing = yspacing + 30
              love.graphics.setColor(1, 1,1, 1)
              lines = lines + 1
            if(lines >= 30) then
              xstart = xstart + 400
              yspacing = 0
              lines = 1
            end
          --end of foor loop
        end
      end
    end
  end
end

function bugdraw:update()
  if keypressed == "d" then
    self.active = true
     keypressed = ""
  end
  if love.keyboard.isDown("f") then
    self.active = false
  end

end

return bugdraw
end
