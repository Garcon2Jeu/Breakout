PauseState = Class { __includes = BaseState }

function PauseState:enter(params)
    self.playState = params
end

function PauseState:update(dt)
    if APP:wasKeyPressed("space") then
        ASSETS.audio["pause"]:play()
        STATE:switchBack()
    end
end

function PauseState:draw()
    ASSETS.colors["setBlackOpaque"]()
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    ASSETS.colors["setWhiteOpaque"]()
    self.playState:draw()

    ASSETS.colors["setWhite"]()
    ASSETS.fonts["setLarge"]()
    love.graphics.printf("PAUSE", 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")

    ASSETS.fonts["setMedium"]()
    love.graphics.printf("Press Space to play", 0, CENTER_HEIGHT, VIRTUAL_WIDTH, "center")
    ASSETS.fonts["setSmall"]()
end
