function getBattleSceneLoader()
  battles = {}
  battles.current_scene = "castle"
  battles.active = false
  battles.loading = false
  battles.battle_start = false
  battles.current_step_count = 0
  battles.transition_steps = 20
  battles.current_battle = {}
  battles.enemies = {}
  battles.total_enemies = 0
  battles.enemies_length = 0
  battles.collumns = 1 --collumns of enemies
  battles.enemy_placement = {}
  battles.enemy_board = {} --list the data of where enemies are on the screen
  battles.enemy_list = {} --name of enemy, and the total
  function battles:getTotalEnemies()
    return self.total_enemies
  end
  function battles:getCurrentScene()
    return self.current_scene
  end
  function battles:getEnemies()
    return self.enemies
  end
  function battles:getEnemiesList()
    return self.enemy_list
  end
  function battles:getEnemyBoard()
    return self.enemy_board
  end

  function battles:isActive()
    return self.active
  end

  function battles:exit()
    self.active = false
    self.loading = false
    self.battle_start = false
    self.current_step_count = 0
    self.current_battle = nil
    self.current_battle = {}
    self.enemies = nil
    self.enemies = {}
    self.enemy_board = nil
    self.enemy_board = {}
    self.enemy_list = nil
    self.enemy_list = {}
    self.total_enemies = 0

    combat_control:unLoadBattle()
    message_controller:turnOffMessages()
    current_game_mode = "in_room"
    bugdraw:removeFromDebug("enemy_debug")
end

  --[[
    This loads a battle. You must send it a battle object wich is created in the enemy spawn object
  ]]
  function battles:loadBattle(bo)
  self.current_scene = bo.battle_scene

  --create first collumn
  table.insert(self.enemy_board,{})


  local collumn_start = false
  local yspacing = 0
  local xspacing = 0
  local collumn = 1
  local row = 1


    for  i,v in pairs(bo.enemy_list) do
        local num = math.random(v.min,v.max)
        enemy_data = enemies[v.name]
        table.insert(self.enemy_list,{
          name = enemy_data.name,
          total = num
        })
        for i = 1, num,1 do
                --check to see if it will appear
          local number_rolled = math.random(1,v.chance)
          local number_needed = math.random(1,v.chance)
            if(number_rolled == number_needed) then

              if collumn_start  then
                  xspacing = xspacing + enemy.sprite_width + 100
                  collumn = collumn + 1
                  row = 1
                  collumn_start = false
                  table.insert(self.enemy_board,{})
                  end

                self.total_enemies = self.total_enemies + 1
                enemy = {}
                local x = 30 + xspacing
                local y = 100 + yspacing
                enemy.x = x
                enemy.y = y
                enemy.collumn = collumn
                enemy.row = row


                enemy.hp = enemy_data.hp
                enemy.mp = enemy_data.mp
                enemy.current_hp = enemy_data.current_hp
                enemy.current_mp = enemy_data.current_mp
                enemy.strength = enemy_data.strength
                enemy.attack = enemy_data.attack
                enemy.defence = enemy_data.defence
                enemy.accuracy = enemy_data.accuracy
                enemy.speed = enemy_data.speed
                enemy.luck = enemy_data.luck
                enemy.evasion = enemy_data.evasion
                enemy.intelligence = enemy_data.intelligence
                enemy.name = enemy_data.name
                enemy.id = enemy_data.name.."-"..self.total_enemies
                enemy.sprite = enemy_data.sprite
                enemy.x = x
                enemy.y = y
                enemy.row = row
                enemy.collumn = collumn
                enemy.sprite_width = enemy_sprites[enemy_data.sprite]:getPixelWidth() * 2.5
                enemy.sprite_height = enemy_sprites[enemy_data.sprite]:getPixelHeight() *2.5


              --  bugdraw:addToDebug(enemy,"Enemy".. self.total_enemies,{
              --    "x","y","row","collumn","hp","mp","name","sprite_width","sprite_height"},_,"enemy_debug")
                table.insert(self.enemies,enemy)

                table.insert(self.enemy_board[collumn],row,{
                  id = enemy.id,
                  x = enemy.x,
                  y = enemy.y,
                  row = enemy.row,
                  collumn = enemy.collumn,
                  width = enemy.sprite_width
                })

                yspacing = yspacing + enemy.sprite_height
                if yspacing > 500 then
                  yspacing = 0
                  collumn_start = true
                end
                row = row + 1


              end
        end


    end




  self.enemies_length = #self.enemies

  self.battle_start = true

  end


  function battles:update()
    if keypressed == "e" then
      keypressed = ""
      self:exit()
    end
    if self.battle_start then
      screen_transitions:doTransition("fade_to_black")
      self.loading = true
    end
    if self.loading then
      if self.current_step_count < self.transition_steps then
        self.current_step_count = self.current_step_count + 1
      else
        self.current_step_count = 0
        self.active = true
        self.loading = false
        self.battle_start = false
        combat_control:loadBattle()
      end
    end
  end




  bugdraw:addToDebug(battles,"Battles Loader",{"enemies_length","total_enemies","battle_start","active","loading","current_step_count","transition_steps","current_scene"})
  return battles
end
