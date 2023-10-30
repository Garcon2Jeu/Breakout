require 'src.dependencies'

function love.load()
    APP = App()
end

function love.update(dt)
end

function love.draw()
    Push:start()
    Push:finish()
end
