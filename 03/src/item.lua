local Item = {}
Item.mt = {__index = Item}

local Quad = require 'src.quad'

local texture = love.graphics.newImage('assets/Food.png')

ITEMS = {
  Quad.new(texture, 0, 0, 16, 16),
  Quad.new(texture, 16, 0, 16, 16),
  Quad.new(texture, 32, 0, 16, 16),
  Quad.new(texture, 48, 0, 16, 16),
  Quad.new(texture, 64, 0, 16, 16),
  Quad.new(texture, 80, 0, 16, 16),
  Quad.new(texture, 96, 0, 16, 16),
  Quad.new(texture, 112, 0, 16, 16)
}

function Item.new()
  local id = math.random(1,  #ITEMS)
  local quad = ITEMS[id]
  local new = {
    id = id,
    len = select(3, quad.quad:getViewport()) * 2, -- radius à la place pour éviter les .5 * len ?
    quad = quad,
    r = math.random(),
    g = math.random(),
    b = math.random()
  }
  setmetatable(new, Item.mt)
  return new
end

function Item.equals(self, other)
  return self.id == other.id
end

return Item