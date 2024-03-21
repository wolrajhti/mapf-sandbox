local utils = {}

function utils.ternary(cond, T, F)
  if cond then return T else return F end
end

return utils