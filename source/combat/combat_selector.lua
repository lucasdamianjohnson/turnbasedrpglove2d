function getCombatSelectr()
  combat_selector = {}
  combat_selector.active = false
  combat_selector.current_mode = "enemy_select_single"
  combat_selector.row = 1
  combat_selector.collumn = 1
  combat_selector.enemy_board = {}

  function combat_selector:turnOn()
    self.enemy_board = combat_control:getEnemyBoard()
    self.collumn = #combat_control:getEnemyBoard()
    self.row = #combat_control:getEnemyBoard()[#combat_control:getEnemyBoard()]
    self.active = true
  end
  function combat_selector:turnOff()
    --self.enemy_board = {}
    self.active = false
  end

  function combat_selector:setEnemyBoard(enemy_board)
    self.enemy_board = nil
    self.enemy_board = enemy_board
  end


  function combat_selector:getSelectedEnemy()
    return combat_control:getEnemyBoard()[self.collumn][self.row].id
  end
  function combat_selector:unLoad()
    combat_selector.enemy_board = nil
    combat_selector.enemy_board = {}
    combat_selector.active = false
    combat_selector.row = 1
    combat_selector.collumn = 1
  end
  --[[
  This funciton loads the select. It will make it active.
  params:
  #enemy_board - this created in the load battle scene
  ]]
  function combat_selector:load()
  --  self.enemy_board = combat_control:getEnemyBoard()
    self.collumn = #combat_control:getEnemyBoard()
    self.row = #combat_control:getEnemyBoard()[#combat_control:getEnemyBoard()]
 end
  function combat_selector:update()

    if self.active then
    eb = combat_control:getEnemyBoard()
    if keypressed == "up" then
      if self.row > 1 then
        self.row = self.row - 1
      end
      keypressed = ""
    end
    if keypressed == "down" then
      if #eb[self.collumn] > self.row then
        self.row = self.row + 1
      end
      keypressed = ""
    end
    if keypressed == "left" then
      if self.collumn > 1 then
        self.collumn = self.collumn - 1
      end
      keypressed = ""
    end
    if keypressed == "right" then
      if #eb > self.collumn then
        self.collumn = self.collumn + 1
        if self.row > #eb[self.collumn] then
           self.row = #eb[self.collumn]
        end
      end
      keypressed = ""
    end
    --end of if active
  end

  end

  function combat_selector:draw()
    if self.active then
      if self.current_mode == "enemy_select_single" then
      eb = combat_control:getEnemyBoard()
      x = eb[self.collumn][self.row].x + eb[self.collumn][self.row].width + 125
      y = eb[self.collumn][self.row].y
      love.graphics.draw(sprites.menu_cursor,x,y,0,-2,2)
      elseif self.current_mode == "enemy_select_all" then
        for i,collumn in ipairs(eb) do
          for x,row in ipairs(eb[i]) do
          x = row.x + row.width + 125
          y = row.y
          love.graphics.setColor(1,1,1,.75)
          love.graphics.draw(sprites.menu_cursor,x,y,0,-2,2)
         end
        end
      end

    end

    love.graphics.setColor(1,1,1,1)
  end

  bugdraw:addToDebug(combat_selector,"Combat Selector",{"active","current_mode","row","collumn"})

  return combat_selector
end
