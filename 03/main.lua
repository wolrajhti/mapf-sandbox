love.graphics.setDefaultFilter('nearest', 'nearest')
love.graphics.setLineStyle('rough')
love.graphics.setLineWidth(2)
local font = love.graphics.newImageFont(
  'assets/Resource-Imagefont.png',
  " abcdefghijklmnopqrstuvwxyz" ..
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
  "123456789.,!?-+/():;%&`'*#=[]\""
)
love.graphics.setFont(font)
local Conveyor = require 'src.conveyor'
local Stock = require 'src.stock'
local ItemStack = require 'src.itemStack'

local w, h = love.graphics.getDimensions()

debug = function (...)
  if DEBUG then
    print(string.format(...))
  end
end
print()
DEBUG = false
PAUSE = false

local conveyor = Conveyor.new(0, h / 2, w, h / 2, 100)

local stock = Stock.new(200, 200, 10)

local itemStack

local message = love.graphics.newText(font, 'D : spawn random itemStack\nCLICK : store current itemStack\nS : spawn itemStream on conveyor\nP : pause')

function love.update(dt)
  if not PAUSE then
    conveyor:update(dt)
  end
end

function love.draw()
  conveyor:draw()
  stock:draw()
  if itemStack then
    local mx, my = love.mouse.getPosition()
    itemStack:draw(mx - 32, my - 32)
  end
  -- love.graphics.setColor(1, 1, 1)
  love.graphics.print(love.timer.getFPS(), w - 100, 10)
  love.graphics.draw(message, w / 2, h - 10, 0, 1, 1, message:getWidth() / 2, message:getHeight())
end

function love.mousepressed()
  if itemStack then
    itemStack = stock:add(itemStack)
  end
  -- for i, conveyor in ipairs(conveyors) do
  --   conveyor:spawn()
  -- end
end

function love.keypressed(key)
  if key == 'd' then
    itemStack = ItemStack:random()
  elseif key == 's' then
    conveyor:spawn()
  elseif key == 'p' then
    PAUSE = PAUSE ~= true
  end
end