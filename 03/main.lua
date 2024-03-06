local Conveyor = require 'src.conveyor'

local w, h = love.graphics.getDimensions()

local conveyors = {}
local N = 100
-- table.insert(conveyors, Conveyor.new(20, 20, 200, 200, 150))
for i = 0, N do
  table.insert(conveyors, Conveyor.new(10 + 5 * i, 10 + 5 * i, w - 10, (h - 5 * (N + 2)) + 5 * i, 100))
end

function love.update(dt)
  for i, conveyor in ipairs(conveyors) do
    conveyor:update(dt)
  end
end

local count = 0
function love.draw()
  for i, conveyor in ipairs(conveyors) do
    conveyor:draw()
  end
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(love.timer.getFPS() .. ' ' .. count, w - 100, 10)
end

function love.mousepressed()
  for i, conveyor in ipairs(conveyors) do
    conveyor:spawn()
  end
  count = count + N
end