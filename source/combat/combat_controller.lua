function getCombatController()
  combat_control = {}
  require("source/combat/draw_magic")
  draw_magic = getMagicDrawer()
  require("source/combat/combat_selector")
  combat_selector = getCombatSelectr()
  require("source/combat/combat_turns")
  combat_turns =  getCombatTurns()
  require("source/combat/combat_draw")
  combat_draw = getCombatDraw()
  require("source/combat/combat_messages")
  combat_messages = getCombatMessages()
  combat_control.active = false
  combat_control.enemy_board = {}
  combat_control.enemy_list = {}
  combat_control.party_list = {}
  combat_control.enemies = {}
  combat_control.total_enemies = 0
  combat_control.current_scene = ""
  combat_control.exit_timer = 100
  combat_control.exit_timer_current_step = 1
  combat_control.exit = false

  function combat_control:combatTurnActive()
      return combat_turns:isActive()
  end

  function combat_control:updateEnemyBoard(enemy_board)
    self.enemy_board = nil
     self.enemy_board = enemy_board
  end
  function combat_control:updateEnemies(enemies)
     self.enemies = enemies
  --[[   bugdraw:removeFromDebug("enemy_debug")
     for i,enemy in pairs(self.enemies) do
       bugdraw:addToDebug(enemy,"Enemy"..i,{
         "x","y","row","collumn","hp","mp","name","sprite_width","sprite_height"},_,"enemy_debug")
     end]]


  end
  function combat_control:updatePartyList(party_list)
     self.party_list = nil
     self.party_list = party_list
  end
  function combat_control:updateEnemyList(enemy_list)
     self.enemy_list = nil
     self.enemy_list = enemy_list
  end
  function combat_control:removeFromEnemyBoard(enemy_id)
    for i,enemy in ipairs(self.enemy_board) do
          if enemy.id == enemy_id then
            table.remove(self.enemy_board,i)
          end
    end
  end
  function combat_control:getEnemyBoard()
    return self.enemy_board
  end
  function combat_control:getTotalEnemies()
    return self.total_enemies
  end
  function combat_control:getEnemies()
    return self.enemies
  end
  function combat_control:getPartyList()
    return self.party_list
  end
  function combat_control:getEnemyList()
    return self.enemy_list
  end
  function combat_control:executeTurn(turn_data)
    combat_turns:executeTurn(turn_data)
  end


  function combat_control:unLoadBattle()
    combat_selector:unLoad()
    combat_draw:turnOff()
    menus:endBattle()
    combat_turns:unLoad()
    bugdraw:removeFromDebug("turn_data_debug")
    self.active = false
    self.enemies = nil
    self.enemies = {}
    self.enemy_board = nil
    self.enemy_board = {}
    self.enemy_list = nil
    self.enemy_list = {}
    self.party_list = nil
    self.party_list = {}
    self.total_enemies = 0
    self.exit = false
    self.exit_timer_current_step = 1
  end

function combat_control:removeEnemy(index)
  id = self.enemies[index].id
  table.remove(self.enemies,index)



for x,v in ipairs(self.enemy_board) do
  for y,k in ipairs(self.enemy_board[x]) do
    if v[y].id == id then
      table.remove(self.enemy_board[x],y)
  end
     if v[1] == nil then
       table.remove(self.enemy_board,x)
    end
end
end

if self.enemies[1] == nil then
   self.exit = true
else
 combat_selector:load()
end

end

  function combat_control:enemySelectOn()
    combat_selector:setEnemyBoard(self.enemy_board)
    combat_selector:turnOn()
  end

  function combat_control:enemySelectOff()
    combat_selector:turnOff()
  end
  --[[
  this function returns the selected enemy and turns off the selector
  ]]
  function combat_control:getSelectedEnemy()
    combat_selector:turnOff()
    return combat_selector:getSelectedEnemy()
  end

  function combat_control:loadBattle()
    self.enemies = battles:getEnemies()
    self.total_enemies = battles:getTotalEnemies()
    self.enemy_list = battles:getEnemiesList()
    self.enemy_board = battles:getEnemyBoard()
    self.party_list = party:getPartyList()
    self.current_scene = battles:getCurrentScene()
    self.active = true
    combat_draw:turnOn()
    combat_turns:startBattle(self.enemies,self.party_list,self.enemy_board)
    current_game_mode = "in_battle"
  --message = newMessage("the battle is starting!")
  --message_controller:turnOnMessages()
  --message_controller:addMessage(message,true)
    menus:startBattle(self.enemy_list,self.party_list)
  end
  function combat_control:update()
    if battles:isActive() then
    combat_selector:update()
    draw_magic:update()
    combat_turns:update()
    combat_draw:update()
        if self.exit then
          if self.exit_timer_current_step >= self.exit_timer / 2 then
          screen_transitions:doTransition("exit_battle")
        end

            if self.exit_timer_current_step < self.exit_timer then
                self.exit_timer_current_step = self.exit_timer_current_step  + 1
            elseif self.exit_timer_current_step == self.exit_timer then

              battles:exit()
              combat_control:unLoadBattle()

            end
      end
  end
end




  function combat_control:drawBackground()

    combat_draw:drawBackground()
  end


  function combat_control:draw()
combat_draw:drawParty()
combat_draw:drawEnemies()


      combat_selector:draw()
      combat_messages:draw()
      --draw_magic:draw()


  end

    bugdraw:addToDebug(combat_control,"Combat Control",{"active","exit_timer","exit_timer_current_step","exit"})
  return combat_control
end
