local ItemStream = {}
ItemStream.mt = {__index = ItemStream}

function ItemStream.new(item, count, stride, path, t)
  local new = {
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

function ItemStream.draw(self)
  love.graphics.setColor(self.r, self.g, self.b)
  local t = self.t - .5 * self.item.len / self.path.len
  local x, y
  -- print('---')
  for i = 0, self.count - 1 do
    -- print('count', i, t)
    if 0 < t then
      x, y = self.path:at(t)
      love.graphics.circle('fill', x, y, .5 * self.item.len)
    end
    t = t - self.stride / self.path.len
  end
  -- print('===')
end

function ItemStream.debug(self)
  -- print(string.format('item.len = %.2f stride = %.2f count = %d t = %.3f tMin = %.3f', self.item.len, self.stride, self.count, self.t, self:tMin()))
end

function ItemStream.tMin(self) -- TODO non prio à stocker en cache ?
  return self.t - ((self.count - 1) * self.stride + self.item.len) / self.path.len
end

function ItemStream.update(self, dt, tMax, previous) -- tMax = previous:tMin()
  -- print('size', self.item.len / self.path.len)
  if self.t > tMax then
    -- TODO WIP pourquoi c'est possible que self.t > tMax ??? à revoir
    return tMax
  end
  self.t = self.t + dt
  if tMax < self.t then
    -- print('overflow', (self.t - tMax) * self.path.len)
  end
  local jammed = math.max(0, math.min(math.ceil((self.t - tMax) / ((self.stride - self.item.len) / self.path.len)), self.count)) -- TODO WIP nb d'items bloqués (à cleaner)
  if 0 < jammed then
    -- print('jammed', jammed)
    -- des items sont bloqués
    if previous and previous.item.len == self.item.len then
      -- ils peuvent être concaténés avec l'itemStream précédent
      -- previous:debug()
      -- self:debug()
      -- print('---')
      previous.count = previous.count + jammed
      self.count = self.count - jammed
      self.t = self.t - jammed * self.stride / self.path.len
      -- previous:debug()
      -- self:debug()
      if 0 < self.count then
        -- il reste des items dans le stream
        return self:tMin()
      else
        -- le stream est vide
        return previous:tMin()
      end
    elseif jammed == self.count then
      -- on modifie l'instance en la compactant
      self.t = tMax
      self.stride = self.item.len
      return self:tMin()
    else
      -- on retourne une nouvelle instance
      self.count = self.count - jammed
      self.t = self.t - jammed * self.stride / self.path.len
      return self:tMin(), ItemStream.new(self.item, jammed, self.item.len, self.path, tMax)
    end
  else
    return self:tMin()
  end
end

return ItemStream