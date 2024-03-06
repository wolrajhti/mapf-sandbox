local Item = {}
Item.mt = {__index = Item}

function Item.new(len)
  local new = {
    len = len, -- radius à la place pour éviter les .5 * len ?
    r = math.random(),
    g = math.random(),
    b = math.random()
  }
  setmetatable(new, Item.mt)
  return new
end

return Item