require 'src.dependencies'

function love.load()
    APP = App()
    ASSETS = AssetManager()
end

function love.update(dt)
    APP:update(dt)
end

function love.draw()
    Push:start()
    ASSETS:drawBackground()
    Push:finish()
end

function love.keypressed(key)
    APP.keyspressed[key] = true
end
