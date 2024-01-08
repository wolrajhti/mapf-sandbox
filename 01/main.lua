package.cpath = "./out/Debug/?.dll"
require "hello"

function love.draw()
  love.graphics.print(hello.say_hello(), 400, 300)
end