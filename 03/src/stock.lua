local Stock = {}
Stock.mt = {__index = Stock}

function Stock.new(x, y, capacity)
  local font = love.graphics.getFont()
  local new = {
    x = x,
    y = y,
    capacity = capacity
  }
  setmetatable(new, Stock.mt)
  return new
end

function Stock.unshift(self, item)
  table.insert(self.items, item)
  self.text.setText(#self.items..'/'..self.capacity)
end

function Stock.draw(self)
  love.graphics.setColor(1, 1, 1)
end

return Stock