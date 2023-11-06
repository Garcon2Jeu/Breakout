require 'src.dependencies'

function love.load()
    APP = App()
    ASSETS = AssetManager()

    STATE = StateManager {
        ["start"]        = function() return StartState() end,
        ["selectPaddle"] = function() return SelectPaddleState() end,
        ["scoreBoard"]   = function() return ScoreBoardState() end,
        ["serve"]        = function() return ServeState() end,
        ["play"]         = function() return PlayState() end,
        ["pause"]        = function() return PauseState() end,
        ["victory"]      = function() return VictoryState() end,
        ["over"]         = function() return OverState() end,
        ["enterScore"]   = function() return EnterScoreState() end,
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
    Push:finish()
end

function love.keypressed(key)
    APP.keysPressed[key] = true
end
