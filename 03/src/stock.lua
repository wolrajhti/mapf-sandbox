local Stock = {}
Stock.mt = {__index = Stock}

local Image = require 'src.image'
local ItemStack = require 'src.itemStack'

MAX_CAPACITY = 6

function Stock.new(x, y)
  local font = love.graphics.getFont()
  local new = {
    x = x,
    y = y,
    itemStacks = {},
    image = Image.new('assets/Stock.png'),
  }
  setmetatable(new, Stock.mt)
  return new
end

function Stock.add(self, itemStack)
  -- on dispatch sur les itemStacks existants
  local dq
  for i, iS in ipairs(self.itemStacks) do
    iS:take(itemStack)
    if itemStack.quantity == 0 then
      return nil
    end
  end
  -- s'il reste des items à stocker on regarde s'il y a des emplacements de libres
  if itemStack.quantity > 0 then
    if #self.itemStacks < MAX_CAPACITY then
      table.insert(self.itemStacks, itemStack)
      return nil
    end
  end
  return itemStack
end

function Stock.draw(self)
  love.graphics.setColor(1, 1, 1)
  self.image:draw(2, self.x, self.y)
  love.graphics.circle('fill', self.x, self.y, 2)
  local i, j = 0, 0
  for _, itemStack in ipairs(self.itemStacks) do
    itemStack:draw(self.x + i * 40 - self.image.ox - 5, self.y + j * 42 - self.image.oy + 4)
    i = i + 1
    if i > 2 then
      i = 0
      j = j + 1
    end
  end
end

return Stock