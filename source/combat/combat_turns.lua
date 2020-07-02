function getCombatTurns()
  combat_turns = {}
  combat_turns.turn_data = {}
  combat_turns.active = false
  combat_turns.turn_cooldown = false
  combat_turns.turn_steps = 50
  combat_turns.turn_current_steps = 0
  combat_turns.turn_cooldown_steps = 50
  combat_turns.enemy_turn_data = {}
  combat_turns.party_list = {}
  combat_turns.enemies = {}
  combat_turns.enemy_board = {}
  combat_turns.total_party_members = 0
  --combat vars
  --[[who strikes first, either enemy or player]]
  combat_turns.current_side_acting = ""
  combat_turns.current_player = 1 --the current player acting
  combat_turns.current_enemy = 1 --the current enemy acting
  --[[the target of the action of the current player ]]
  combat_turns.current_player_target = ""
  --[[the target of the action of the current enemy ]]
  combat_turns.current_enmey_target = ""

  function combat_turns:getActivePlayer()
    return self.current_player
  end

    function combat_turns:isActive()
      return self.active
    end
  function combat_turns:unLoad()
      self.enemy_turn_data = nil
      self.enemy_turn_data = {}
      self.turn_data = nil
      self.turn_data = {}
      self.party_list = nil
      self.party_list = {}
      self.enemies = nil
      self.enemies = {}
      self.turn_current_steps = 0
      self.current_player = 1
      self.current_ennemy = 1
      self.turn_cooldown = false
      self.active = false
  end


  function combat_turns:generateEnemyTurnData()
      data = {}
      for i,enemy in pairs(self.enemies) do
          et_data = {
          enemy_id = enemy.id,
          method = "attack",
          enemy_target = math.random(1,#party:getPartyList())
        }





          table.insert(data,et_data )
      end

      return data
  end

  function combat_turns:startBattle(enemies,party_list,enemy_board)
    self.enemies = enemies
    self.party_list = party_list
    self.enemy_board = enemy_board
    self.total_party_members = #self.party_list
  end
  function combat_turns:executeTurn(turn_data)
    self.turn_data = turn_data
    self.enemy_turn_data = combat_turns:generateEnemyTurnData()

    self.active = true


    self.current_side_acting = "party"
  end



function combat_turns:update()
 if self.active then
    if self.turn_cooldown ~= true then

      if self.turn_current_steps < self.turn_steps  then
        self.turn_current_steps = self.turn_current_steps + 1
      elseif self.turn_current_steps >= self.turn_steps then
             --start turn
                self.turn_current_steps = 0
          if self.current_side_acting == "party" then


                        turn_data =  self.turn_data[self.current_player]
                        if turn_data.method == "attack" or turn_data.method == "magic" then

                              for i,enemy in ipairs(combat_control:getEnemies()) do
                                --------------------

                                  --  bugdraw:addToDebug(self.enemies[i],"Enemy!!",{"id"})
                                  if enemy.id == turn_data.player_target then
                                    local x = enemy.x + combat_control:getEnemies()[i].sprite_width / 2
                                    local y = enemy.y + combat_control:getEnemies()[i].sprite_height / 2 + 50
                                    local row = enemy.row
                                    local collumn = enemy.collumn
                                    local current_hp = enemy.hp
                                      if turn_data.method == "attack" then
                                        local attack =  party:getPartyList()[self.current_player].attack
                                        enemy.hp = current_hp - attack

                                        if enemy.hp <= 0 then

                                          combat_messages:drawMessage("damage","DEAD",x,y)
                                          combat_control:removeEnemy(i)

                                        else
                                        combat_messages:drawMessage("damage",attack,x,y)
                                       end
                                      elseif turn_data.method == "magic" then

                                      end
                            end
                     end
                   end
                          --end of loop


                      if turn_data.method == "item" then
                      end
                      if turn_data.method == "flee" then
                      end
                      turn_data = nil
                      if self.current_player < #self.party_list then
                        self.current_player = self.current_player + 1
                        self.turn_current_steps = 0
                        self.turn_cooldown = true
                      elseif self.current_player == #self.party_list then
                        self.current_player = 1
                        self.turn_cooldown = true
                        self.current_side_acting = "enemies"

                      end


      --end of check party
        elseif self.current_side_acting == "enemies" then
         combat_messages:drawMessage("damage","hey this worked!!!",500,500)
          if combat_control:getEnemies()[self.current_enemy] then

          enemy_turn_data =  self.enemy_turn_data[self.current_enemy]
          if enemy_turn_data.method == "attack" or turn_data.method == "magic" then

                for i,p in ipairs(party:getPartyList()) do

                    --  bugdraw:addToDebug(self.enemies[i],"Enemy!!",{"id"})
                    if i == enemy_turn_data.enemy_target then
                      --local x = enemy.x + combat_control:getEnemies()[i].sprite_width / 2
                      --local y = enemy.y + combat_control:getEnemies()[i].sprite_height / 2 + 50
                      --local row = enemy.row
                      --local collumn = enemy.collumn
                      local current_hp = p.current_hp
                        if enemy_turn_data.method == "attack" then
                          local attack =  combat_control:getEnemies()[self.current_enemy].attack
                          p.current_hp = current_hp - attack

                          if p.current_hp <= 0 then

                            combat_messages:drawMessage("damage","DEAD",500,500)
                            --combat_control:removeEnemy(i)

                          else
                          combat_messages:drawMessage("damage",attack,500,500)
                         end
                        elseif enemy_turn_data.method == "magic" then

                        end
              end

           --end of loop
           end
      end



        if enemy_turn_data.method == "item" then
        end
        if enemy_turn_data.method == "flee" then
        end
        enemy_turn_data = nil





        if self.current_enemy < #combat_control:getEnemies() then
          self.current_enemy = self.current_enemy + 1
          self.turn_current_steps = 0
          self.turn_cooldown = true
        elseif self.current_enemy == #combat_control:getEnemies() then
          self.current_enemy = 1

          self.active = false
          self.current_side_acting = "party"
          self.turn_cooldown = true
        end

end --the end of checking if enemy is nill
-----------------------------------------------------------------------------------
end --the end of enemies turn
-----------------------------------------------------------------------------------
end --the end of executing the turn
-----------------------------------------------------------------------------------
elseif self.turn_cooldown then

              if self.turn_current_steps < self.turn_cooldown_steps then
                  self.turn_current_steps = self.turn_current_steps + 1
              elseif self.turn_current_steps == self.turn_cooldown_steps then
                  self.turn_current_steps = 0
                  self.turn_cooldown = false
              end


              --end of check cooldown
          end

        --if active
    end
end



  bugdraw:addToDebug(combat_turns,"Combat Turns",{"active","turn_cooldown","total_party_members","turn_steps","turn_current_steps","current_ennemy","current_player","current_side_acting"})
 return combat_turns
end
