function getInGameMenu()


  ingamemenu = {}
  ingamemenu.ative = false

  ingamemenu.options = {}
 ingamemenu.totalOptions = 7
 ingamemenu.active_index = 1

 local testthing = false
 option = {}
 option.name = "Items"
function option.update()
  menus.state = "itemsmenu"
end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Magic"
function option.update()

end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Equitment"
function option.update()

end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Status"
function option.update()
end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Formaiton"
function option.update()
end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Configuration"
function option.update()
end
table.insert(ingamemenu.options,option)

option = {}
option.name = "Save"
function option.update()
end
table.insert(ingamemenu.options,option)



  function ingamemenu:draw()

    --dostuff

    if self.active then
      --part 1
      xstart = 0
      ystart = 30
      width = 1500
      height = 800
      love.graphics.setLineWidth(10)
      love.graphics.setColor(255, 255, 255, 1)
      love.graphics.rectangle("line", xstart, ystart, width, height)
      love.graphics.setLineWidth(0)
      love.graphics.setColor(0, 0, 100, .5)
      love.graphics.rectangle("fill", xstart, ystart, width, height)
      love.graphics.setColor(255, 255, 255, 1)
      --player display
      player.anim = player.animations.walkLeft
      player.anim:gotoFrame(1)
      player.anim:draw(sprites.redMageWalkSheet, xstart +150, ystart + 150, nil, 3, 3, player.width, player.height)
      --part 2
      xstart = 1500
      ystart = 30
      width = 400
      height = 320
      love.graphics.setLineWidth(10)
      love.graphics.setColor(255, 255, 255, 1)
      love.graphics.rectangle("line", xstart, ystart, width, height)
      love.graphics.setLineWidth(0)
      love.graphics.setColor(0, 0, 100, .5)
      love.graphics.rectangle("fill", xstart, ystart, width, height)
      love.graphics.setColor(255, 255, 255, 1)
      --part 3
      xstart = 1500
      ystart = 350
      width = 400
      height = 475
      love.graphics.setLineWidth(10)
      love.graphics.setColor(255, 255, 255, 1)
      love.graphics.rectangle("line", xstart, ystart, width, height)
      love.graphics.setLineWidth(0)
      love.graphics.setColor(0, 0, 100, .5)
      love.graphics.rectangle("fill", xstart, ystart, width, height)
      love.graphics.setColor(255, 255, 255, 1)

    spacing = 0
    for i,option in ipairs(ingamemenu.options)  do
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.setFont(fonts.ingamemenu)
        if(self.active_index == i) then
        --love.graphics.circle("fill", xstart + 25, 80 + spacing, 8)
        love.graphics.draw(sprites.menu_cursor, xstart+20, 65 + spacing)
      end
        love.graphics.print(option.name, xstart + 50,50 + spacing)
        spacing = spacing + 40
        --end of for loop
    end
    if testthing then
      love.graphics.print("hey this WorkeD!", 0,0)
    end



  end
  --end of function
  end


  function ingamemenu:update()
    if menus.state == "ingamemenu" then
      self.active = true
      playercanmove = false
    else
      self.active = false
      playercanmove = true
      self.active_index = 1
    end
    if self.active then
    if(menus.scroll_cooldown_current <= 0) then

    if keypressed == "c" then
      self.options[self.active_index].update()
      keypressed = ""
    end
    if keypressed == "up" then
      if self.active_index > 1 then
      self.active_index = self.active_index - 1
    end
    keypressed = ""
    end
    if  keypressed == "down" then
      if self.active_index < self.totalOptions then
        self.active_index = self.active_index + 1
      end
    keypressed = ""
    end
    menus.scroll_cooldown_current = menus.scroll_cooldown
  end
  end
  menus.scroll_cooldown_current = menus.scroll_cooldown_current -1
  --end of function
  end



  return ingamemenu

end
