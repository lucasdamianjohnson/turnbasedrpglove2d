function getCombatMessages()
    combat_messages = {}
    combat_messages.active = false
    combat_messages.message = {}
    combat_messages.draw_steps = 30
    combat_messages.current_steps = 0
    combat_messages.down_steps = 0
    function combat_messages:update()

    end

    function combat_messages:draw()
      if self.active then
        if self.current_steps < self.draw_steps then




           if self.message.type == "damage" then
             love.graphics.setColor(1,0,0,1)
             love.graphics.setFont(fonts.combat)
             if self.current_steps < self.draw_steps / 2 then
              yy = self.message.y - self.current_steps * 4
            elseif self.current_steps == self.draw_steps / 2 then
              self.message.y = self.message.y - self.current_steps * 4
              yy = self.message.y
            elseif self.current_steps > self.draw_steps / 2 then
              yy = self.message.y + self.down_steps * 4
              self.down_steps = self.down_steps + 1
            elseif self.current_steps > self.draw_steps * (8/10) then
              self.message.y = self.message.y + self.down_steps * 4
            end

             love.graphics.print(self.message.message,self.message.x,yy)
           elseif self.message.type == "debug" then
             love.graphics.setColor(1,0,0,1)
             love.graphics.setFont(fonts.combat)
            love.graphics.print(self.message.message,self.message.x,self.message.y)
           end

             self.current_steps = self.current_steps + 1
        else
           self.down_steps = 0
           self.current_steps = 0
           self.active = false


        end



      end



    end

    function combat_messages:drawMessage(type,message,x,y)
       self.current_steps = 0
        m = {
          type = type,
          message = message,
          x = x,
          y = y
        }
          bugdraw:addToDebug(m,"Message",{"type","message","x","y"})
        self.message = m
        self.active = true
    end
  bugdraw:addToDebug(combat_messages,"Combat Messages",{"active","current_steps","draw_steps"})
    return combat_messages
end
