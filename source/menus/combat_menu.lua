function getCombatMenu()

  combat_menu = {}
  combat_menu.active = true
  combat_menu.execute_turn = false
  combat_menu.mode = "select"
  combat_menu.enemy_list = {}
  combat_menu.option_list = {}
  combat_menu.selected_option = "none"
  combat_menu.current_option = "attack"
  combat_menu.active_index = 1 --the selected option index
  combat_menu.current_party_member = ""
  combat_menu.party_member_index_current = 1
  combat_menu.party_turn_data = {}
  combat_menu.party_list = {}
  --create options
  option = {}
  option.name = "Attack"
  function option.select()
    combat_menu.selected_option = "attack"
    combat_control:enemySelectOn()
    combat_menu.mode = "select_enemy"
  end
  function option.update()
    combat_menu.selected_option = "none"
    combat_menu.mode = "select"
    enemy_id = combat_control:getSelectedEnemy()

    local data = {
      party_id = combat_menu.current_party_member,
      method = "attack",
      player_target = enemy_id
    }
    combat_menu:updateTurnData(data)
  end
  table.insert(combat_menu.option_list,option)
  option = {}
  option.name = "Magic"
  function option.select()
    combat_menu.selected_option = "magic"
  end
  table.insert(combat_menu.option_list,option)
  option = {}
  option.name = "Defend"
  function option.select()
    combat_menu.selected_option = "defend"
  end
  table.insert(combat_menu.option_list,option)
  option = {}
  option.name = "Items"
  function option.select()
    combat_menu.selected_option = "items"
  end
  table.insert(combat_menu.option_list,option)
  option = {}
  option.name = "Equip"
  function option.select()
    combat_menu.selected_option = "equip"
  end
  table.insert(combat_menu.option_list,option)
  option = {}
  option.name = "Flee"
  function option.select()
    combat_menu.selected_option = "flee"
  end
  table.insert(combat_menu.option_list,option)
  option = nil
  combat_menu.total_options = #combat_menu.option_list

   function combat_menu:isActive()
     return self.execute_turn ~= true
   end
  function combat_menu:returnCurrentPartyMember()
    return self.current_party_member
  end
  function combat_menu:close()
    self.active = false
    self.enemy_list = nil
    self.enemy_list = {}
    self.party_list = {}
    self.party_list = nil
    self.mode = "select"
    self.execute_turn = false
    return true
  end
  function combat_menu:setPartyList(party_list)
    self.party_list = party_list
    self.current_party_member = self.party_list[1].name
  end
  function combat_menu:setEnemyList(enemy_list)
    self.enemy_list = enemy_list
  end

  function combat_menu:turnOn()
    self.active = true
  end
  function combat_menu:turnOff()
    self.active = false
  end

  function combat_menu:update()

    self.execute_turn = combat_control:combatTurnActive()


    if self.active  and self.mode == "select" and self.execute_turn ~= true then
    if keypressed == "up" then
      if self.active_index > 1 then
      self.active_index = self.active_index - 1
    end
    keypressed = ""
    end
    if  keypressed == "down" then
      if self.active_index < self.total_options then
        self.active_index = self.active_index + 1
      end
    keypressed = ""
    end
   if keypressed == "c" then
     self.option_list[self.active_index].select()
     keypressed = ""
    end

  end

  if self.mode == "select_enemy" then
    if keypressed == "c" then
      self.option_list[self.active_index].update()
      keypressed = ""
     end
    end



end

  function combat_menu:updateTurnData(data)
     bugdraw:removeFromDebug("turn_data_debug")
    bugdraw:addToDebug(data,"Turn data"..combat_menu.current_party_member,{
      "party_id","method","player_target"},_,"turn_data_debug")
    table.insert(combat_menu.party_turn_data,data)
    if self.party_member_index_current < #self.party_list then
      self.party_member_index_current = self.party_member_index_current + 1
      self.current_party_member = self.party_list[self.party_member_index_current].name
    elseif self.party_member_index_current == #self.party_list then

      combat_control:executeTurn(self.party_turn_data)
      self.party_member_index_current = 1
      self.current_party_member = self.party_list[self.party_member_index_current].name
      self.execute_turn = combat_control:combatTurnActive()
      self.party_turn_data = nil
      self.party_turn_data = {}
    end
  end
  function combat_menu:draw()
    if self.active then
    xstart = 10
    ystart = 850
    width = window.width / 2
    height = 225
    drawMessageBox(xstart,ystart,width,height)
    xstart = window.width / 2 + 22
    ystart = 850
    width = (window.width / 2) - 10
    height = 225
    drawMessageBox(xstart,ystart,width,height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(fonts.ingamemenu)

    --draw list of enemies
    local yspacing = 0
    for i,enemy in ipairs(self.enemy_list) do
      love.graphics.print(enemy.name,15,860 + yspacing)
      love.graphics.print(enemy.total,window.width / 2 - 40, 860 + yspacing)
      yspacing = yspacing + 20
    end

    ---draw party data
    xstart = xstart + 30
    local yspacing = 0
    for _,party_member in pairs(self.party_list) do

      love.graphics.print(party_member.name,xstart,860 + yspacing)
      love.graphics.print(party_member.current_hp.."/", xstart + 260,860 + yspacing)
      love.graphics.print(party_member.max_hp, xstart + 460,860 + yspacing)
      love.graphics.print(party_member.current_mp,window.width - 50 ,860 + yspacing)
      yspacing = yspacing + 40

    end


    --draw option box
    xstart = window.width / 4 + 80
    ystart = 850
    width = window.width / 4 - 70
    height = 225
    yspacing = 0
    drawMessageBox(xstart,ystart,width,height)
      for option_index,option in ipairs(self.option_list) do
        if option_index == self.active_index and self.execute_turn ~= true then
          love.graphics.draw(sprites.menu_cursor, xstart+25, 855 + yspacing,0,2,2)
        end
          love.graphics.print(option.name,xstart + 100,860 + yspacing)
          yspacing = yspacing + 50
      end




    end
  end


  bugdraw:addToDebug(combat_menu,"Combat Menu",{"active","execute_turn","current_party_member","current_option","active_index","mode"})
return combat_menu
end
