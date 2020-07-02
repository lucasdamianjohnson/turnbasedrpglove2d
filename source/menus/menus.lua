function getMenus()

  menus = {}
  menus.state = "none"
  menus.scroll_cooldown = 5
  menus.scroll_cooldown_current = 0



  require("source/menus/ingamemenu")
  ingamemenu = getInGameMenu()
  require("source/menus/itemsmenu")
  itemsmenu = getItemsMenu()
  require("source/menus/combat_menu")
  combat_menu = getCombatMenu()

  function menus:battleMenuActive()
    return combat_menu:isActive()
  end
  function menus:getCurrentPartyMemberInBattle()
    return combat_menu:returnCurrentPartyMember()
  end
  function menus:startBattle(enemy_list,party_list)

   self.state = "combat_menu"
   combat_menu:turnOn()
   combat_menu:setEnemyList(enemy_list)
   combat_menu:setPartyList(party_list)
  end
  function menus:endBattle()

   combat_menu:close()
   self.state = "none"
  end
  function menus:setState(state)
    self.state = state or "none"
    return true
  end
  function menus:draw()

    ingamemenu:draw()
    itemsmenu:draw()
    if self.state == "combat_menu" then
      combat_menu:draw()
    end
  end

  function menus:update()

    if love.keyboard.isDown("z") then
      menus.state="ingamemenu"
    end
    if love.keyboard.isDown("a") then
      menus.state="itemsmenu"
    end

    if love.keyboard.isDown("x") then
      if self.state =="itemsmenu" then
      message_controller.active = false
    end
      self.state="none"



    end


    ingamemenu:update()
    itemsmenu:update()
    combat_menu:update()
  end
return menus

end
