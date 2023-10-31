SelectPaddleState = Class { __includes = BaseState }

local paddleSkin = 2

function SelectPaddleState:update(dt)
    if APP:wasKeyPressed("right") then
        paddleSkin = paddleSkin + 4 > #ATLAS.paddles - 2 and paddleSkin or paddleSkin + 4
    elseif APP:wasKeyPressed("left") then
        paddleSkin = paddleSkin - 4 < 2 and paddleSkin or paddleSkin - 4
    end

    if APP:wasKeyPressed("return") then
        STATE:change("serve", paddleSkin)
    end
end

function SelectPaddleState:draw()
    ASSETS.fonts["setMedium"]()
    love.graphics.printf("SELECT PADDLE", 0, CENTER_HEIGHT - 50, VIRTUAL_WIDTH, "center")

    self:drawArrow(2, 1, -100)

    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.paddles[paddleSkin]["quad"],
        CENTER_WIDTH - (ATLAS.paddles[paddleSkin]["width"] / 2), CENTER_HEIGHT)

    self:drawArrow(#ATLAS.paddles - 2, 2, 76)

    ASSETS.fonts["setSmall"]()
    love.graphics.printf("press enter to continue", 0, CENTER_HEIGHT + 50, VIRTUAL_WIDTH, "center")
end

function SelectPaddleState:drawArrow(opaqueIndex, skin, xOffset)
    if paddleSkin == opaqueIndex then
        ASSETS.colors["setSemiOpaque"]()
    end

    love.graphics.draw(ASSETS.graphics["arrows"], ATLAS.arrows[skin].quad, CENTER_WIDTH + xOffset, CENTER_HEIGHT - 5)
    ASSETS.colors["setWhite"]()
end
