function getGameObjectController()
  goc = {}
  goc.objects = {}

  function goc:draw()

    for i,v in ipairs(self.objects) do
        v:draw()
    end
  end
  function goc:update()
    for i,v in ipairs(self.objects) do
        v:update(dt)
    end
  end


  function goc:addObject(object)
    table.insert(self.objects,object)
  end


  return goc


end
