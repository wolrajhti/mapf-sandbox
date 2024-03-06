local Path = require 'src.path'
local Item = require 'src.item'

local Conveyor = {}
Conveyor.mt = {__index = Conveyor}

function Conveyor.new(sx, sy, ex, ey, speed)
  local new = {
    path = Path.new(sx, sy, ex, ey),
    speed = speed,
    items = {},
  }
  setmetatable(new, Conveyor.mt)
  new:setSpeed(speed)
  return new
end

function Conveyor.update(self, dt)
  for i, item in ipairs(self.items) do
    item:update(dt * self.delta)
  end
end

function Conveyor.draw(self)
  love.graphics.setColor(1, 1, 1)
  self.path:draw()
  for i, item in ipairs(self.items) do
    item:draw()
  end
end

function Conveyor.setSpeed(self, speed)
  self.speed = speed
  self:_updateDelta()
end

function Conveyor.setPath(self, path)
  self.path = path
  self:_updateDelta()
end

function Conveyor._updateDelta(self)
  self.delta = self.speed / self.path.len
end

function Conveyor.spawn(self)
  local item = Item.new(self.path, 0)
  table.insert(self.items, item)
end

return Conveyor