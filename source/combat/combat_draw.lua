function getCombatDraw()

  combat_draw = {}
  combat_draw.active = false
  combat_draw.current_scene = ""

  function combat_draw:turnOn()
      self.active = true
      self.current_scene = battles:getCurrentScene()
  end
  function combat_draw:turnOff()
      self.active = false
  end
  function combat_draw:update()

  end

  function combat_draw:drawBackground()
    if self.active then
        love.graphics.draw(battlescenes[self.current_scene].background_image,0,0,0,4,4)
    end
  end

  function combat_draw:drawParty()
    if self.active then
          local yspacing = 0
          local xoffset = 0
            for _,party_member in pairs(party:getPartyList()) do
                    if combat_turns:isActive() and party:getPartyList()[combat_turns:getActivePlayer()].name == party_member.name then
                          xoffset = 200
                    elseif menus:getCurrentPartyMemberInBattle() == party_member.name and menus:battleMenuActive() then
                      xoffset = 100
                    else
                      xoffset = 0
                    end
                    love.graphics.draw(party_sprites[party_member.standing_sprite], window.width- 400  - xoffset, 150 + yspacing, 0, 3,3)
                    yspacing = yspacing + 150
          end
  end
end


  function combat_draw:drawEnemies()
      if self.active then
            for i,enemy in ipairs(combat_control:getEnemies()) do
                  if #combat_control:getEnemies() == 1 then
                    love.graphics.draw(enemy_sprites[enemy.sprite],30,100,0,2.5,2.5)
                elseif #combat_control:getEnemies() > 1 then
                    love.graphics.draw(enemy_sprites[enemy.sprite],enemy.x,enemy.y,0,2.5,2.5)
                end
          end

        end
end



return combat_draw
end
