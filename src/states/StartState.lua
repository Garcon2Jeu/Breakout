StartState = Class { __includes = BaseState }

local highlighted = 1

function StartState:update(dt)
    if APP:wasKeyPressed("up") or APP:wasKeyPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
    end
end

function StartState:draw()
    ASSETS.fonts["setLarge"]()
    love.graphics.printf("BREAKOUT", 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")


    ASSETS.fonts["setMedium"]()

    if highlighted == 1 then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf("Start", 0, CENTER_HEIGHT + 20, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()


    if highlighted == 2 then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf("Score Board", 0, CENTER_HEIGHT + 40, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()
end
