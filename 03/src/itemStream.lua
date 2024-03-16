local ItemStream = {}
ItemStream.mt = {__index = ItemStream}

function ItemStream.new(item, count, stride, path, t)
  local new = {
    offset = 0,
    item = item,
    count = count,
    stride = stride,
    path = path,
    t = t or 0,
    r = math.random(),
    g = math.random(),
    b = math.random(),
  }
  setmetatable(new, ItemStream.mt)
  return new
end

function ItemStream.draw(self, i)
  local t = self.t - .5 * self.item.len / self.path.len
  local x, y
  if DEBUG then
    love.graphics.setColor(1, 0, 0)
    x, y = self.path:at(self:tMin())
    love.graphics.line(x, y - 10, x, y + 10)
    x, y = self.path:at(self.t)
    love.graphics.setColor(0, 1, 0)
    love.graphics.line(x, y - 10, x, y + 10)
    love.graphics.print(i, x - 5, y + 15)
  end
  love.graphics.setColor(self.r, self.g, self.b)
  for i = 0, self.count - 1 do
    if 0 < t then
      x, y = self.path:at(t)
      love.graphics.circle('fill', x, y, .5 * self.item.len)
    end
    t = t - self.stride / self.path.len
  end
end

function ItemStream.tMin(self) -- TODO non prio à stocker en cache ?
  if self.count == 0 then
    return self.t
  else
    return self.t - ((self.count - 1) * self.stride + self.item.len) / self.path.len
  end
end

function ItemStream.update(self, dt, tMax, previous) -- tMax = previous:tMin()
  debug('count = %d; t = %.2f; tMax = %.2f', self.count, self.t, tMax)
  if self.t == tMax then
    debug('STOP')
    return false, self:tMin()
  end
  if self.t + dt <= tMax then
    debug('NO COLLISION')
    self.t = self.t + dt
    return true, self:tMin()
  end
  local jammed = self.count
  if self.item.len < self.stride then
    jammed = math.ceil(self.path.len * (dt - tMax + self.t - self.offset) / (self.stride - self.item.len))
  end
  -- TODO erreur d'arrondi, thx lua
  debug('JAMMED = %d', jammed)
  if previous and previous.item.len == self.item.len then
    debug('MERGE', jammed)
    -- ils peuvent être concaténés avec l'itemStream précédent
    previous.count = previous.count + jammed
    self.count = self.count - jammed
    self.t = math.max(0, math.min(tMax - jammed * self.stride / self.path.len, 1))
    return jammed < self.count, self:tMin()
  end
  if jammed == self.count then
    debug('UPDATE', jammed)
    -- on modifie l'instance en la compactant
    self.t = tMax
    self.stride = self.item.len
    return false, self:tMin()
  end
  debug('SPLIT', jammed)
  -- on retourne une nouvelle instance
  self.count = self.count - jammed
  self.t = tMax - jammed * self.stride / self.path.len
  return jammed < self.count, self:tMin(), ItemStream.new(self.item, jammed, self.item.len, self.path, tMax)
end

return ItemStream