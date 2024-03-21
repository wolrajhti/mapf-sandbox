local ItemStack = {}
ItemStack.mt = {__index = ItemStack}

MAX_ITEMS = {
  100,
  100,
  100,
  100,
  100,
  100,
  100,
  100,
}

function ItemStack.new(itemId, quantity)
  local font = love.graphics.getFont()
  local new = {
    itemId = itemId,
    quantity = quantity,
    text = love.graphics.newText(font, quantity)
  }
  setmetatable(new, ItemStack.mt)
  return new
end

function ItemStack.random(self)
  local itemId = math.random(1, #ITEMS)
  local quantity = math.random(1, MAX_ITEMS[itemId])
  return self.new(itemId, quantity)
end

function ItemStack.capacity(self)
  return MAX_ITEMS[self.itemId] - self.quantity
end

function ItemStack.take(self, other)
  if self.itemId == other.itemId then
    local dq = math.min(other.quantity, self:capacity())
    self:setQuantity(self.quantity + dq)
    other:setQuantity(other.quantity - dq)
  end
end

function ItemStack.setQuantity(self, quantity)
  self.quantity = quantity
  self.text:set(quantity)
end


function ItemStack.draw(self, x, y)
  love.graphics.setColor(1, 1, 1)
  ITEMS[self.itemId]:draw(2, x, y)
  love.graphics.draw(self.text, x, y, 0, 1, 1, self.text:getWidth() / 2, self.text:getHeight() / 2)
end

return ItemStack