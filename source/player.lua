function createPlayer(name,class)
  player = {}
  player.width = 28
  player.height = 32

  player.playercanmove = true
  player.current_battle_region = ""
  player.battle_region_id = ""




  player.isMoving = false
  player.dir = "down"


  player.query_timer = 10
  player.query_timer_current = 0



  -- Physics properties
  player.collider = world:newCircleCollider(150, 150, 14)
  player.collider:setCollisionClass("Player")

  player.x = player.collider:getX()
  player.y = player.collider:getY()

  player.grids = {}
  player.grids.walk = anim8.newGrid(player.width, player.height, sprites.redMageWalkSheet:getWidth(), sprites.redMageWalkSheet:getHeight())

  player.animations = {}
  player.animations.walkDown = anim8.newAnimation(player.grids.walk('1-2', 1), 0.175)
  player.animations.walkRight = anim8.newAnimation(player.grids.walk('5-6', 1), 0.175)
  player.animations.walkLeft = anim8.newAnimation(player.grids.walk('5-6', 1), 0.175)
  player.animations.walkUp = anim8.newAnimation(player.grids.walk('3-4', 1), 0.175)
  -- This value stores the player's current animation
  player.anim = player.animations.walkDown

  function player:update(dt)



    if player.playercanmove then
    -- Freeze the animation if the player isn't moving
    if self.isMoving then
        self.anim:update(dt)
    end


    local vectorX = 0
    local vectorY = 0

    -- Keyboard direction checks for movement
    if love.keyboard.isDown("left") then
        vectorX = -1
        self.anim = self.animations.walkLeft
        self.dir = "left"
    end
    if love.keyboard.isDown("right") then
        vectorX = 1
        self.anim = player.animations.walkRight
        self.dir = "right"
    end
    if love.keyboard.isDown("up") then
        vectorY = -1
        self.anim = self.animations.walkUp
        self.dir = "up"
    end
    if love.keyboard.isDown("down") then
        vectorY = 1
        self.anim = self.animations.walkDown
        self.dir = "down"
    end

    self.collider:setLinearVelocity(vectorX * 200, vectorY * 200)
    -- Check if player is moving
    if vectorX == 0 and vectorY == 0 then
        self.isMoving = false
        self.anim:gotoFrame(1) -- go to standing frame
    else
        self.isMoving =  true
    end
  end


  self.x = self.collider:getX()
  self.y = self.collider:getY()

  end

function player:draw()
  local px = self.collider:getX()
  local py = self.collider:getY()

--  if self.query_timer_current < self.query_timer then
  --self.query_timer_current = self.query_timer_current + 1
--  else
--  self.query_timer_current = 0
  local colliders = world:queryCircleArea(px, py, 14, {"EnemySpawn"})
  for i,c in ipairs(colliders) do
    self.current_battle_region = c.name
    self.battle_region_id = c.spawn_id
  end
--  end

  -- sx represents the scale on the x axis for the player animation
  -- If it is -1, the animation will flip horizontally (for walking left)
  local sx = 1
  if self.anim == self.animations.walkLeft then
      sx = -1
  end

  -- Draw the player's walk animation
  love.graphics.setColor(1, 1, 1, 1)
  self.anim:draw(sprites.redMageWalkSheet, px, py + 10, nil, sx, 1, self.width/2, self.height/1.3)


end



  bugdraw:addToDebug(player,"Player",{"x","y","current_battle_region","battle_region_id"})
return player
end
