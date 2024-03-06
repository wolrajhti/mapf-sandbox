local Path = require 'src.path'
local Item = require 'src.item'
local ItemStream = require 'src.itemStream'

local Conveyor = {}
Conveyor.mt = {__index = Conveyor}

function Conveyor.new(sx, sy, ex, ey, speed)
  local new = {
    path = Path.new(sx, sy, ex, ey),
    speed = speed,
    itemStreams = {}, -- on stock les itemStream du plus ancien au plus récent
  }
  setmetatable(new, Conveyor.mt)
  new:setSpeed(speed)
  return new
end

function Conveyor.update(self, dt)
  local tMax, new = 1
  dt = dt * self.delta -- on multiplie par la vitesse du tapis roulant
  -- print(string.format('dt * delta = %.3f', dt))
  local i = 1
  while i <= #self.itemStreams do
    -- self.itemStreams[i]:debug()
    -- print(string.format('updating itemStream i = %d', i))
    if i == 1 then
      tMax, new = self.itemStreams[i]:update(dt, tMax)
    else
      tMax, new = self.itemStreams[i]:update(dt, tMax, self.itemStreams[i - 1])
    end
    if self.itemStreams[i].count == 0 then
      table.remove(self.itemStreams, i) -- TODO non prio pas du tout opti
    else
      if new then
        table.insert(self.itemStreams, i, new)
      end
      i = i + 1
    end
  end
end

function Conveyor.draw(self)
  love.graphics.setColor(1, 1, 1)
  self.path:draw()
  for i, itemStream in ipairs(self.itemStreams) do
    itemStream:draw()
  end
end

function Conveyor.setSpeed(self, speed)
  self.speed = speed
  self:_updateDelta()
end

-- function Conveyor.setPath(self, path)
--   self.path = path
--   self:_updateDelta()
-- end

function Conveyor._updateDelta(self)
  self.delta = self.speed / self.path.len
end

function Conveyor.spawn(self)
  local item = Item.new(8)
  local itemStream = ItemStream.new(item, 7, 16, self.path, 0)
  table.insert(self.itemStreams, itemStream)
end

return Conveyor