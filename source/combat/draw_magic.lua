function getMagicDrawer()
  magic_draw = {}
  magic_draw.current_step = 0
  magic_draw.wait_step = 50
  magic_draw.x = 100
  magic_draw.y = 100
  magic_draw.transition_current = 0
  magic_draw.transition_max = 200
  magic_draw.fade = 1
  magic_draw.current_spell = "test"
  magic_draw.spells = {}

  function magic_draw:draw()

    if self.current_spell == "test" then

      if self.current_step < self.wait_step then
        self.current_step = self.current_step + 1

        if self.transition_current < self.transition_max then
            self.transition_current = self.transition_current +  self.transition_max / self.wait_step
        else
          self.fade = 1
          self.transition_current = 0
          love.graphics.setColor(0,1,0,0)
        end
        if self.transition_current <= self.transition_max / 2 then
        love.graphics.setColor(0,1,0,self.transition_current/self.transition_max)
      elseif self.transition_current > self.transition_max / 2 then
        self.fade = (self.transition_current / self.transition_max)
        love.graphics.setColor(0,1,0,1 - (self.transition_current / self.transition_max))
      end
        love.graphics.setLineWidth(10)
        love.graphics.circle( "line", self.x + self.transition_current, self.y +self.transition_current, 20 )
      else
        self.current_step = 0
      end

    end

  end
  function magic_draw:update()

  end


  bugdraw:addToDebug(magic_draw,"Magic Drawer",{"x","y","fade","transition_current","transition_max","current_step","wait_step"})
  return magic_draw
end
