local Conveyor = require 'src.conveyor'

local w, h = love.graphics.getDimensions()

local conveyors = {}
local N = 1
debug = function (...)
  if DEBUG then
    print(string.format(...))
  end
end
print()
DEBUG = true

table.insert(conveyors, Conveyor.new(0, h / 2, w, h / 2, 100))

for i = 0, N do
  -- table.insert(conveyors, Conveyor.new(10 + 5 * i, 10 + 5 * i, w - 10, (h - 5 * (N + 2)) + 5 * i, 100))
end

function love.update(dt)
  if love.keyboard.isDown('space') then
    for i, conveyor in ipairs(conveyors) do
      conveyor:update(dt)
    end
  end
end

function love.draw()
  for i, conveyor in ipairs(conveyors) do
    conveyor:draw()
  end
  -- love.graphics.setColor(1, 1, 1)
  love.graphics.print(love.timer.getFPS(), w - 100, 10)
end

function love.mousepressed()
  for i, conveyor in ipairs(conveyors) do
    conveyor:spawn()
  end
end