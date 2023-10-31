require 'src.dependencies'

function love.load()
    APP = App()
    ASSETS = AssetManager()

    STATE = StateManager {
        ["start"] = function() return StartState() end
    }

    STATE:change("start")

    ATLAS = AtlasManager()
end

function love.update(dt)
    STATE:update(dt)
    APP:update(dt)
end

function love.draw()
    Push:start()
    ASSETS:drawBackground()
    STATE:draw()
    ATLAS:draw()
    Push:finish()
end

function love.keypressed(key)
    APP.keysPressed[key] = true
end
