local Stock = require 'stock'

local Transformer = {}
Transformer.mt = {__index = Transformer}

function Transformer.new(x, y, inputs, outputs)
  local new = {
    x = x,
    y = y,
    inputs = inputs,
    outputs = outputs
  }
  setmetatable(new, Transformer.mt)
  return new
end

function Transformer.update(self, dt)
end

function Transformer.draw(self)
  love.graphics.setColor(0, 1, 0)
  for i = 0, #self.inputs do
    love.graphics.circle('fill', self.x - )
  end
  love.graphics.setColor(1, 0, 0)
end

function Transformer.setSpeed(self, speed)
  self.speed = speed
  self:_updateDelta()
end

function Transformer.setPath(self, path)
  self.path = path
  self:_updateDelta()
end

function Transformer._updateDelta(self)
  self.delta = self.speed / self.path.len
end


local Stock = require 'stock'  table.insert(self.items, ite

end

return Transformer