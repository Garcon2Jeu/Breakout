StartState = Class { __includes = BaseState }

local topChoice = true

function StartState:update(dt)
    if APP:wasKeyPressed("up") or APP:wasKeyPressed("down") then
        topChoice = not topChoice
    end

    if not APP:wasKeyPressed("return") then
        return
    end

    if topChoice then
        STATE:change("enterScore")
    else
        STATE:change("scoreBoard")
    end
end

function StartState:draw()
    ASSETS.fonts["setLarge"]()
    love.graphics.printf("BREAKOUT", 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")


    ASSETS.fonts["setMedium"]()

    if topChoice then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf("Start", 0, CENTER_HEIGHT + 20, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()


    if not topChoice then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf("Score Board", 0, CENTER_HEIGHT + 40, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()
end
