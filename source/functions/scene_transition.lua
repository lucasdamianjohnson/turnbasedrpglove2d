function getScreenTransitions()
screen_transitions = {}
screen_transitions.active = false
screen_transitions.current_step_count = 0
screen_transitions.current_transition = "fade_to_black"
screen_transitions.transitions = {
  ['fade_to_black'] = {
    steps = 15,
    zoom = 4,
    wait_steps = 15 --steps to wait after
  },
  ['exit_battle'] = {
    steps = 30,
    zoom = 1,
    wait_steps = 30 --steps to wait after
  }

}
function screen_transitions:setTranistion(transition_name)
self.current_tranistion = transition_name
return self.transitions[transition_name].steps + self.transitions[transition_name].wait_steps
end
function screen_transitions:draw()

if self.active then
----------------------------------------------------------------------------------------------------------------------------------------------
  if self.current_transition == "fade_to_black"  then
      local tkey = "fade_to_black"
      local percent_done = self.current_step_count/self.transitions[tkey].steps
      local zoom_to = self.transitions[tkey].zoom
      if  self.current_step_count < self.transitions[tkey].steps  then
    love.graphics.setColor(0, 0, 0, 1 * percent_done)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getPixelWidth(),love.graphics.getPixelHeight() )


    cam:zoomTo(4+ (percent_done * zoom_to))

    self.current_step_count = self.current_step_count + 1
  else
      cam:zoomTo(4)
    if  self.current_step_count < self.transitions[tkey].steps + self.transitions[tkey].wait_steps  then
    self.current_step_count = self.current_step_count + 1
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getPixelWidth(),love.graphics.getPixelHeight() )
  else
    love.graphics.setColor(1, 1, 1,1)
    self.active = false

    self.current_step_count = 0

  end

  end

--end of fade to black
----------------------------------------------------------------------------------------------------------------------------------------------
elseif  self.current_transition == "exit_battle" then
  local tkey = "exit_battle"
  local percent_done = self.current_step_count/self.transitions[tkey].steps

            if  self.current_step_count < self.transitions[tkey].steps  then
                  love.graphics.setColor(0, 0, 0, 1 * percent_done)
                  love.graphics.rectangle("fill", 0, 0, love.graphics.getPixelWidth(),love.graphics.getPixelHeight() )

                  self.current_step_count = self.current_step_count + 1
          else

          if  self.current_step_count < self.transitions[tkey].steps + self.transitions[tkey].wait_steps  then
                  self.current_step_count = self.current_step_count + 1
                  love.graphics.setColor(0, 0, 0, 1)
                  love.graphics.rectangle("fill", 0, 0, love.graphics.getPixelWidth(),love.graphics.getPixelHeight() )
          else
                  love.graphics.setColor(1, 1, 1,1)
                  self.active = false

                  self.current_step_count = 0

          end

      end

end





--end of active
end
    love.graphics.setColor(1, 1, 1,1)
--end of draw
end

function screen_transitions:doTransition(trans_name)
  self.current_transition = trans_name or "fade_to_black"
  self.active = true
end
function screen_transitions:update()
  if keypressed == "s" then
    self.active = true
      keypressed = ""
  end
  if keypressed == "x" then
    self.active = false
      keypressed = ""
  end
end

  bugdraw:addToDebug(screen_transitions,"Screen Transitions",{"active","current_transition"})
return screen_transitions

end
