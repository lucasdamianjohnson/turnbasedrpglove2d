function loadRoom(room_id)
  roomdata = rooms[room_id]
  path = roomdata.mappath
  local room = require(path)
  render = room.renderorder

  room.quads = {}

  local tileset = room.tilesets[1]
  room.tileset = tileset
  room.image = love.graphics.newImage("source/tilesets/firsttileset.png")

  for y = 0, (tileset.imageheight / tileset.tileheight) - 1 do
      for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do
          local quad = love.graphics.newQuad(
          x * tileset.tilewidth,
          y * tileset.tileheight,
          tileset.tilewidth,
          tileset.tileheight,
          tileset.imagewidth,
          tileset.imageheight)
          table.insert(room.quads, quad)
      end
  end

function room:load()
  walls  = {}
  current_enemy_spawns = {}

for i, layer in ipairs(self.layers) do
  if layer.type == "objectgroup" then
    for i, object in ipairs(layer.objects) do

    if object.type == "wall" then
    local wall = world:newRectangleCollider(object.x
    , object.y,
    object.width,
    object.height)
    wall:setCollisionClass('Wall')
    wall:setType('static')
    table.insert(walls,wall)
  end

  if object.type == "enemy_spawn" then
    local spawner_id = object.properties['enemy_spawn_name']

     goc:addObject(createEnemySpawner(object.id,enemy_spawners_list[spawner_id],object.x,object.y,object.width,object.height))
  end


end


end



end
end
function room:debugdraw()
  for i, layer in ipairs(room.layers) do
love.graphics.print(layer.type,0,0)
  end

end
  function room:draw()

    for i, layer in ipairs(self.layers) do
      if layer.type ~= "objectgroup" and layer.name ~= "background" and layer.name ~= "foreground" then

      for y = 0, layer.height -1 do
        for x = 0, layer.width -1 do
            local index = (x + y * layer.width) + 1
            local tid = layer.data[index]

            if tid ~= 0 then
              local quad = self.quads[tid]
              local xx = x * self.tileset.tilewidth
              local yy = y * self.tileset.tileheight

              love.graphics.draw(room.image,quad,xx,yy)
            end
        end
      end
    end

    end


--end of function
  end

function room:drawBackground()
  for i, layer in ipairs(self.layers) do
    if layer.name == "background" then

    for y = 0, layer.height -1 do
      for x = 0, layer.width -1 do
          local index = (x + y * layer.width) + 1
          local tid = layer.data[index]

          if tid ~= 0 then
            local quad = self.quads[tid]
            local xx = x * self.tileset.tilewidth
            local yy = y * self.tileset.tileheight

            love.graphics.draw(room.image,quad,xx,yy)
          end
      end
    end
  end

  end

end
function room:drawForeground()
  for i, layer in ipairs(self.layers) do
  if layer.name == "foreground" then

    for y = 0, layer.height -1 do
      for x = 0, layer.width -1 do
          local index = (x + y * layer.width) + 1
          local tid = layer.data[index]

          if tid ~= 0 then
            local quad = self.quads[tid]
            local xx = x * self.tileset.tilewidth
            local yy = y * self.tileset.tileheight

            love.graphics.draw(room.image,quad,xx,yy)
          end
      end
    end
  end

  end
end

  return room

end
