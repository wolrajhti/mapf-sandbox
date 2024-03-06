local Path = {}
Path.mt = {__index = Path}

function Path.new(sx, sy, ex, ey)
  local new = {
    len = math.sqrt(math.pow(ex - sx, 2) + math.pow(ey - sy, 2)),
    sx = sx,
    sy = sy,
    ex = ex,
    ey = ey,
    dx = (ex - sx),
    dy = (ey - sy),
  }
  setmetatable(new, Path.mt)
  return new
end

function Path.at(self, t)
  t = math.min(math.max(0, t), 1)
  return self.sx + t * self.dx,
         self.sy + t * self.dy
end

function Path.draw(self)
  love.graphics.line(self.sx, self.sy, self.ex, self.ey)
end

return Path