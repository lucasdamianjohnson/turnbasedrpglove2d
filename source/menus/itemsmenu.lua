function getItemsMenu()
  itemsmenu = {}
  itemsmenu.active = false
  itemsmenu.max_rows = 15
  itemsmenu.current_row = 1
  itemsmenu.current_col = 1
  --max items per collumn
  itemsmenu.max_items = 85
  itemsmenu.lowerbound =1
  itemsmenu.upperbound =15
  itemsmenu.itemhover = false
  function makenewitem(name)
    item = {}
    item.name = name
    item.description = "test for now"
    return item
  end
itemsmenu.items = {}
for x = 1, itemsmenu.max_items do
  table.insert(itemsmenu.items,makenewitem(x))
end



itemstable = {}
itemstable.col_1 = {}
itemstable.col_2 = {}
for i=1,itemsmenu.max_items,2 do
  table.insert(itemstable.col_1,itemsmenu.items[i])
end
for i=2,itemsmenu.max_items,2 do
  table.insert(itemstable.col_2,itemsmenu.items[i])
end

  itemsmenu.itemslist = itemstable




  function itemsmenu:update()
    if menus.state == "itemsmenu" then
      self.active = true
      playercanmove = false
      message_controller:turnOnMessages()
    else
      self.active = false
      playercanmove = true
    end

    --if active
    if self.active then
    if(menus.scroll_cooldown_current <= 0) then

    --c confirm
    if keypressed == "c" then
      keypressed = ""
    end

    --up
  if love.keyboard.isDown("up")then
      if self.current_row > 1 then
      self.current_row = self.current_row - 1
      self.itemhover = false
    end
    keypressed = ""
    if self.current_row == 1 then
      if self.lowerbound > 1 then
        self.lowerbound = self.lowerbound - 1
        self.upperbound = self.upperbound  - 1
      end
      if self.lowerbound == 1 then
        --player error sound
      end

    end
    end

    --down
    if love.keyboard.isDown("down")then
      if self.current_row < self.max_rows then
        self.itemhover = false
        self.current_row = self.current_row + 1
      end

      if self.upperbound < self.max_items / 2 then
      if self.current_row == self.max_rows then
        self.lowerbound = self.lowerbound + 1
        if self.upperbound + 1 < self.max_items then
          self.upperbound = self.upperbound + 1
        else
          self.upperbound = self.max_items
        end
      end
    end

    keypressed = ""
    end

    --right
    if love.keyboard.isDown("right") then
      if self.current_col <= 1 then
      self.current_col = 2
      self.itemhover = false
    end
    keypressed = ""
    end

    --left
    if love.keyboard.isDown("left") then
      if self.current_col == 2 then
      self.current_col = 1
      self.itemhover = false
    end
    keypressed = ""
    end


    menus.scroll_cooldown_current = menus.scroll_cooldown
  end

  --end of active
    menus.scroll_cooldown_current = menus.scroll_cooldown_current -1
  end





  end

  function itemsmenu:draw()
    if self.active then
      --part 1
      xstart = 30
      ystart = 365
      width = 1870
      height = 470



      drawMessageBox(xstart,ystart,width,height)

      love.graphics.setColor(255, 255, 255, 1)
      love.graphics.setFont(fonts.items_in_itemmeu)
    --display items
      ystart = 375
    --collumn 1
      yspacing = 0
      xspacing = 0

      row = 1
      for i,v in ipairs(self.itemslist.col_1) do
        if i >= self.lowerbound and i <= self.upperbound then
        if row == self.current_row and self.current_col == 1 then
          love.graphics.draw(sprites.menu_cursor, xstart+15, yspacing + ystart + 10)
          if self.itemhover == false then
          message = newMessage("This is a potion that restores part of your health.")
          message_controller:addMessage(message,false)
          self.itemhover = true
        end
        end
        --v = self.itemslist.col_1[row]
      --   love.graphics.print(v.name,xstart + 50,yspacing + ystart)
      love.graphics.draw(item_menu_sprites.potion_1,xstart + 50, yspacing + ystart + 10, _,3,3)
      love.graphics.print('Potion',xstart + 80,yspacing + ystart)

        yspacing = yspacing + 30
        row = row + 1
      end
      end
    --end of collumn 1
    --collumn 2
      yspacing = 0
      xspacing = 900
      row = 1
      for i,v in ipairs(self.itemslist.col_2) do
        if i >= self.lowerbound and i <= self.upperbound then
        if row == self.current_row  and self.current_col == 2 then
          love.graphics.draw(sprites.menu_cursor, xstart+ 15 + xspacing, ystart + yspacing + 10)
        end

      --  v = self.itemslist.col_2[i]
      love.graphics.print(v.name,xstart + 50 + xspacing,yspacing+ystart)

        yspacing = yspacing + 30
        row = row + 1
      end
      end
      --end of collumn 2


      --end of active
    end

  
    --end of draw
  end



    return itemsmenu
end
