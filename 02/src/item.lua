local Item = {}
Item.mt = {__index = Item}

function Item.new(path, t)
  local new = {
    path = path,
    t = t or 0,
    r = math.random(),
    g = math.random(),
    b = math.random()
  }
  setmetatable(new, Item.mt)
  new:update(0)
  return new
end

function Item.draw(self)
  love.graphics.setColor(self.r, self.g, self.b)
  love.graphics.circle('fill', self.x, self.y, 8)
end

function Item.update(self, dt)
  self.t = math.min(math.max(0, self.t + dt), 1)
  self.x, self.y = self.path:at(self.t)
end

return Item