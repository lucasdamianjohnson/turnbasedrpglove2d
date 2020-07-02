--[[
This file  contains  custom global variables and functions
]]


--[[
Defines the current game mode.
Values include:
in_room -when player is just in a room
in_battle -when player is in a battle scene
in_menu -when the player is using the menu
]]
current_game_mode = "in_room"


keypressed = "none"
function love.keypressed( key )
   if key == "up" then
     keypressed = "up"
   end
   if key == "down" then
     keypressed = "down"
   end
   if key == "left" then
     keypressed = "left"
   end
   if key == "right" then
     keypressed = "right"
   end
   if key == "c" then
     keypressed = "c"
   end

   if key == "m" then
     keypressed = "m"
   end
   if key == "d" then
     keypressed = "d"
   end
   if key == "s" then
     keypressed = "s"
   end
   if key == "b" then
     keypressed = "b"
   end
   if key == "e" then
     keypressed = "e"
   end
end



-- Returns the x, y position that is in front of Link
-- "dist" number of pixels away
function getLinkFrontPosition(dist)

    local px, py = player.collider:getPosition()

    if player.dir == "right" then
        px = px + dist
    elseif player.dir == "left" then
        px = px - dist
    elseif player.dir == "up" then
        py = py - dist
    elseif player.dir == "down" then
        py = py + dist
    end

    return px, py

end

--only call in draw
function drawMessageBox(xstart,ystart,width,height)

  xstart = xstart or 30
  ystart = ystart or 50
  width = width or 100
  height = height or 100
  love.graphics.setLineWidth(10)
  love.graphics.setColor(255, 255, 255, 1)
  love.graphics.rectangle("line", xstart, ystart, width, height)
  love.graphics.setLineWidth(0)
  love.graphics.setColor(.13, .13, .62, .8)
  love.graphics.rectangle("fill", xstart, ystart, width, height)
  love.graphics.setColor(255, 255, 255, 1)
end

function explode(inputstring, seperator)
        if seperator == nil then
                seperator = "%s"
        end
        local t={}
        for str in string.gmatch(inputstring, "([^"..seperator.."]+)") do
                table.insert(t, str)
        end
        return t
end
