--[[
This creates the objects the enemy spawner regions in the game.
These are linked to the enemy spawners list.
params:
#ref - takes the enemy spawn region object to create object - see enemiesspawners.lua
#x - x cordinate of spwan region collion rectangle
#y - y cordinate of spwan region collion rectangle
#width - width  of spwan region collion rectangle
#height - height  of spwan region collion rectangle
]]
function createEnemySpawner(id,ref,x,y,width,height)

  spawner =  world:newRectangleCollider(x, y, width,height)
  spawner:setCollisionClass("EnemySpawn")
  spawner:setType('static')
  spawner.active = false
  spawner.spawn_id = id
  spawner.spawns = {}
  spawner.wait_steps = ref.wait_steps or 100
  spawner.current_step = 0
  spawner.name = ref.name or "default"
  spawner.descrption = ref.desciption or "default desc."
  spawner.battles_generated = 0
  --Set number to chances out of 1 - i.e 2 - 1/2 chance and so on
  spawner.chance = ref.chance or 2
  spawner.inbattle ="no"
  spawner.number_rolled = 0
  spawner.number_needed = 0
  spawner.ref = ref




  function spawner:draw()


  end



  function spawner:update(dt)

    if player.battle_region_id == self.spawn_id then
      self.active = true
    else
      self.active = false
    end

    if self.active and self.name ~= "safe_zone" then
    if player.isMoving then
    if  self.current_step < self.wait_steps then
        self.current_step = self.current_step + 1
    else
        self.current_step = 0
         self.number_needed = math.random(1,self.chance)
         self.number_rolled = math.random(1,self.chance)
        if(self.number_needed == self.number_rolled) then

          self.inbattle = "yes"
          self.battles_generated = self.battles_generated + 1
          battles:loadBattle(self.ref)
          self.current_step = 0

        else
          self.inbattle = "no"
          self.current_step = 0
        end

        end
      end
    end
  end



  bugdraw:addToDebug(spawner,"Spawn Region Info",{"inbattle","spawn_id","current_step","wait_steps","number_needed","number_rolled","battles_generated"},"active")
  return spawner
end
