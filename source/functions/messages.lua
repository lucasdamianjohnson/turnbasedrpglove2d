
--creates messageController
function messageController()
  message_controller = {}
  message_controller.active = false
  --set default max chars per row
  message_controller.max_chars = 80
  --set default max rows of text
  message_controller.max_rows = 4
  --set default message
  message_controller.message = newMessage("This is going to be a very long messaage that I am going to write for testing purposes. Here I am writing a very long message that will surely will be good for testing this game. Wow if you made it this far than that means something is working in the game. If you never see this part of this message than you are probably very frustrated.")
  message_controller.current_char_count = 0
  message_controller.printed_words = {}
  --set default dimensions
  message_controller.x = 30
  message_controller.y = 850
  message_controller.width = 1870
  message_controller.height = 225

  --set default values for fadding text
  message_controller.fade_text = true
  message_controller.xspacing = 0
  message_controller.yspacing = 0
  message_controller.duration = 15
  message_controller.count = 1
  message_controller.message_count = 0

  function message_controller:turnOnMessages()
    self.active = true;
  end
  function message_controller:turnOffMessages()
    self.active = false;
  end
  function message_controller:deleteAllMessage()


  end
  --[[
  Parameters:
  newMessage -> this is a mssage object, create with newMessage("the message")
  fade_text -> bool - wether to fade the text
  duration -> num - how long it takes to fade in the text
  max_chars -> num - how many chars per row of text
  max_rows -> num - how many rows of text to show at a time
  x -> num - x start posiiton of message rectagnle
  y -> num - y start position of message rectangle
  width -> num - width of message rectangle
  height -> num - height of message rectangle
  ]]
  function message_controller:addMessage(new_message,fade_text,duration,max_chars,max_rows,x,y,width,height)
    self.message = new_message or newMessage("please add message")

    if fade_text then
      self.fade_text = true
    else
      self.fade_text = false
    end

    self.duration = duration or 15
    self.max_chars = max_chars or 80
    self.max_rows = max_rows or 4
    self.x = x or 30
    self.y = y or 850
    self.width = width or 1870
    self.height = height or 225


    --reset
    self.printed_words = {}
    self.xspacing = 0
    self.yspacing = 0
    self.current_char_count = 0
    self.message_count = 0
  end
  function message_controller:update()

        if keypressed == "m" then
          self.active = true
          keypressed = ""
        end
  end
  function message_controller:draw()




      if self.active then
        drawMessageBox(self.x,self.y,self.width,self.height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(fonts.items_in_itemmeu)

        --show the already printed world
        local xstart = 30 + self.x
        local ystart = 30 + self.y
        local xspacing = 0
        local yspacing = 0
        local current_char_count = 0
        local testspace = 50
        local extraspacing = 0
        if self.fade_text then
        for i,word in ipairs(self.printed_words) do
          current_char_count = current_char_count + string.len(word)
         if current_char_count  >= self.max_chars then
           yspacing =  yspacing + 40
           current_char_count = 0
           xspacing = 0
         end

           if self.count <self.duration and i == #self.printed_words and #self.message.parsed > #self.printed_words then
         love.graphics.setColor(1, 1, 1, self.count/self.duration)
       else
          love.graphics.setColor(1, 1, 1, 1)
       end
        love.graphics.print(word,xspacing + xstart,ystart + yspacing)

        if(string.len(word) <= 2) then
           extraspacing = 10
        else
           extraspacing = 0
        end
         xspacing = xspacing  + (string.len(word) * 20) + extraspacing
         --end of foor loop
        end

        --showing the words one by one
        if self.count <self.duration then
        self.count = self.count + 1

        else
           self.count = 1
           if self.message_count < #self.message.parsed then
           self.message_count = self.message_count + 1
           message_text = self.message.parsed[self.message_count]
            self.current_char_count = self.current_char_count + string.len(message_text)
           if self.current_char_count  >= self.max_chars then
             self.yspacing = self.yspacing + 30
             self.current_char_count = 0
             self.xspacing = 0

           end
          table.insert(self.printed_words,message_text)
          love.graphics.setColor(1, 1, 1, .1)
          love.graphics.setColor(1, 1, 1, self.count / self.duration)
          love.graphics.print(message_text,xstart + self.xspacing,ystart + self.yspacing)

          if(string.len(message_text) <= 2) then
             extraspacing = 10
          else
             extraspacing = 0
          end
          self.xspacing = self.xspacing  + (string.len(message_text) * 20) + extraspacing
        end
        end
      else
         --end of fade text
         local xstart = 30 + self.x
         local ystart = 30 + self.y
         local xspacing = 0
         local yspacing = 0
         local current_char_count = 0
         local testspace = 50
         local extraspacing = 0
         --just shwo the text
         for i,word in ipairs(self.message.parsed) do
           current_char_count = current_char_count + string.len(word)
          if current_char_count  >= self.max_chars then
            yspacing =  yspacing + 40
            current_char_count = 0
            xspacing = 0
          end

            if self.count <self.duration and i == #self.printed_words and #self.message.parsed > #self.printed_words then
          love.graphics.setColor(1, 1, 1, self.count/self.duration)
        else
           love.graphics.setColor(1, 1, 1, 1)
        end
         love.graphics.print(word,xspacing + xstart,ystart + yspacing)

         if(string.len(word) <= 2) then
            extraspacing = 10
         else
            extraspacing = 0
         end
          xspacing = xspacing  + (string.len(word) * 20) + extraspacing
          --end of foor loop
         end

       end

       end

      --end of draw
      love.graphics.setColor(1, 1, 1, 1)
  end
  return message_controller

end


function newMessage(message_text)
    message = {}

    message.text = message_text
    message.parsed = explode(message_text)

    return message
end
