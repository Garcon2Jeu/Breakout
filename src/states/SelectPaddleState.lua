SelectPaddleState = Class { __includes = BaseState }


local highlighted   = true
local paddleSkin    = 2
local ballSkin      = 1
local paddleArrowsY = CENTER_HEIGHT - 55
local ballArrowsY   = CENTER_HEIGHT + 42.5


function SelectPaddleState:update(dt)
    if APP:wasKeyPressed("down") or APP:wasKeyPressed("up") then
        highlighted = not highlighted
    end


    self:selectPaddle()
    self:selectBall()


    if APP:wasKeyPressed("return") then
        ASSETS.audio["confirm"]:play()
        self.paddle = Paddle(paddleSkin)
        self.balls  = BallManager(ballSkin)
        self.player = PlayerStats()
        self.map    = MapManager:factory(self.player)

        STATE:change("serve", self)
    end
end

function SelectPaddleState:selectPaddle()
    if not highlighted then
        return
    end

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

function SelectPaddleState:selectBall()
    if highlighted then
        return
    end

    if APP:wasKeyPressed("right") then
        if ballSkin + 1 > 7 then
            ASSETS.audio["no_select"]:play()
        else
            ballSkin = ballSkin + 1
            ASSETS.audio["select"]:play()
        end
    elseif APP:wasKeyPressed("left") then
        if ballSkin - 1 < 1 then
            ASSETS.audio["no_select"]:play()
        else
            ballSkin = ballSkin - 1
            ASSETS.audio["select"]:play()
        end
    end
end

function SelectPaddleState:draw()
    ASSETS.fonts["setMedium"]()
    self:drawPaddle()
    self:drawBall()

    ASSETS.fonts["setSmall"]()
    love.graphics.printf("press enter to continue", 0, CENTER_HEIGHT + 100, VIRTUAL_WIDTH, "center")
end

function SelectPaddleState:drawArrow(objectSkin, opaqueIndex, arrowSkin, xOffset, y)
    if objectSkin == opaqueIndex then
        ASSETS.colors["setWhiteOpaque"]()
    end

    love.graphics.draw(ASSETS.graphics["arrows"], ATLAS.arrows[arrowSkin].quad, CENTER_WIDTH + xOffset, y)
    ASSETS.colors["setWhite"]()
end

function SelectPaddleState:drawPaddle()
    if highlighted then
        ASSETS.colors["setYellow"]()
    end

    love.graphics.printf("SELECT PADDLE", 0, CENTER_HEIGHT - 100, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()

    self:drawArrow(paddleSkin, 2, 1, -100, paddleArrowsY)

    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.paddles[paddleSkin]["quad"],
        CENTER_WIDTH - (ATLAS.paddles[paddleSkin]["width"] / 2), CENTER_HEIGHT - 50)

    self:drawArrow(paddleSkin, #ATLAS.paddles - 2, 2, 76, paddleArrowsY)
end

function SelectPaddleState:drawBall()
    if not highlighted then
        ASSETS.colors["setYellow"]()
    end

    love.graphics.printf("SELECT Ball", 0, CENTER_HEIGHT, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()

    self:drawArrow(ballSkin, 1, 1, -100, ballArrowsY)

    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.balls[ballSkin]["quad"],
        CENTER_WIDTH - (ATLAS.balls[ballSkin]["width"] / 2), CENTER_HEIGHT + 50)

    self:drawArrow(ballSkin, 7, 2, 76, ballArrowsY)
end
