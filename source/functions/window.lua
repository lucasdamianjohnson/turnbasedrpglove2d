function getWindow()
  window = {}
  window.width = love.graphics.getPixelWidth()
  window.height = love.graphics.getPixelHeight()

  function window:update()

    self.width = love.graphics.getPixelWidth()
    self.height = love.graphics.getPixelHeight()
   end

   bugdraw:addToDebug(window,"Window Info",{"width","height"})
 return window
end
