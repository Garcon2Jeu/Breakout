SelectPaddleState = Class { __includes = BaseState }


local paddleSkin = 2


function SelectPaddleState:update(dt)
    self:select()
    if APP:wasKeyPressed("return") then
        ASSETS.audio["confirm"]:play()
        self.paddle = Paddle(paddleSkin)
        self.ball   = Ball()
        self.player = PlayerStats()
        self.map    = MapManager:factory(self.player)

        STATE:change("serve", self)
    end
end

function SelectPaddleState:select()
    if APP:wasKeyPressed("right") then
        if paddleSkin + 4 > #ATLAS.paddles - 2 then
            ASSETS.audio["no_select"]:play()
        else
            paddleSkin = paddleSkin + 4
            ASSETS.audio["select"]:play()
        end
    elseif APP:wasKeyPressed("left") then
        if paddleSkin - 4 < 2 then
            ASSETS.audio["no_select"]:play()
        else
            paddleSkin = paddleSkin - 4
            ASSETS.audio["select"]:play()
        end
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
        ASSETS.colors["setWhiteOpaque"]()
    end

    love.graphics.draw(ASSETS.graphics["arrows"], ATLAS.arrows[skin].quad, CENTER_WIDTH + xOffset, CENTER_HEIGHT - 5)
    ASSETS.colors["setWhite"]()
end
