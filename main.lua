

local shader = nil
function love.load()

    require("source/startup/gameStart")
    gameStart()


end


function love.update(dt)

  if current_game_mode == "in_room" then
  player:update(dt)
  goc:update(dt)
  world:update(dt)
  end


  menus:update(dt)
  battles:update(dt)
  combat_control:update(dt)
  message_controller:update(dt)
  screne_transitions:update(dt)

  window:update(dt)
  bugdraw:update(dt)
end




function love.draw()



        --room:debugdraw()

        cam:attach()



        if current_game_mode == "in_room" then
        cam:zoomTo(4)
        cam:lookAt(player.x,player.y)
        room:drawBackground()
        room:draw()
        player:draw()
        goc:draw()
        room:drawForeground()



        --world:draw()

      elseif current_game_mode == "in_battle" then

        cam:zoomTo(1)
        cam:lookAt(980,550)
        combat_control:drawBackground()
        combat_control:draw()
      end
        cam:detach()
        menus:draw()
        message_controller:draw()
        screne_transitions:draw()
        bugdraw:draw()



end
