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
  local rawDt = dt
  dt = dt * self.delta -- on multiplie par la vitesse du tapis roulant
  debug('#itemStreams = %d, dt = %.2f, dt * speed / path.len = %.2f', #self.itemStreams, rawDt, dt)
  local i = 1
  local stopSearch = false
  while i <= #self.itemStreams do
    debug('i = %d', i)
    if stopSearch then
      debug('AUTO')
      self.itemStreams[i].t = self.itemStreams[i].t + dt
      i = i + 1
    else
      if i == 1 then
        stopSearch, tMax, new = self.itemStreams[i]:update(dt, tMax)
      else
        stopSearch, tMax, new = self.itemStreams[i]:update(dt, tMax, self.itemStreams[i - 1])
      end
      if self.itemStreams[i].count == 0 then
        table.remove(self.itemStreams, i) -- TODO non prio pas du tout opti
      else
        if new then
          table.insert(self.itemStreams, i, new)
          i = i + 1
        end
        i = i + 1
      end
    end
  end
end

function Conveyor.draw(self)
  love.graphics.setColor(1, 1, 1)
  self.path:draw()
  for i, itemStream in ipairs(self.itemStreams) do
    itemStream:draw(i)
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
  local item = Item.new(8 + 4 * math.random(0, 1))
  local itemStream = ItemStream.new(item, 7, 15 + math.random(0, 10), self.path, 0)
  table.insert(self.itemStreams, itemStream)
end

return Conveyor