Ball = Class {}

local SPEED = 75

function Ball:init(skin, x, y)
    self.skin = skin or 1
    self.x = x or 0
    self.y = y or STATE.current.paddle.y - 25
    self.dx = 0
    self.dy = -50
    self.hitbox = Hitbox(self.x, self.y,
        ATLAS.balls[self.skin].width + 2, ATLAS.balls[self.skin].height + 2)
end

function Ball:update(dt)
    self:move(dt)
    self.hitbox:update(self.x - 2, self.y - 2)
    self:clamp()
    self:bounceOffPaddle()
    self:hitBricks()
    self:isLost()
end

function Ball:draw()
    love.graphics.draw(ASSETS.graphics["breakout"],
        ATLAS.balls[self.skin].quad, self.x, self.y)

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self.hitbox:draw()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:clamp()
    if self.dy < 0 and self.y <= 0 then
        self.y = 0
        self.dy = -self.dy * .9
        ASSETS.audio["wall_hit"]:play()
        return
    end

    if self.dx < 0 and self.x <= 0 then
        self.x = 0
        self.dx = -self.dx * .9
        ASSETS.audio["wall_hit"]:play()
        return
    end

    if self.dx > 0 and self.x + ATLAS.balls[self.skin].width >= VIRTUAL_WIDTH then
        self.x = VIRTUAL_WIDTH - ATLAS.balls[self.skin].width
        self.dx = -self.dx * .9
        ASSETS.audio["wall_hit"]:play()
        return
    end
end

function Ball:isLost()
    return self.dy > 0 and self.y >= VIRTUAL_HEIGHT
end

function Ball:bounceOffPaddle()
    if not self.hitbox:hasCollided(STATE.current.paddle.hitbox) then
        return
    end

    ASSETS.audio["paddle_hit"]:play()

    self.y = STATE.current.paddle.y - ATLAS.balls[self.skin].height
    self.dy = -self.dy

    local paddleCenter = STATE.current.paddle.x +
        (ATLAS.paddles[STATE.current.paddle.skin].width / 2)
    local multiplier = STATE.current.paddle.x +
        ATLAS.paddles[STATE.current.paddle.skin].width / 2 - self.x

    if self.x < paddleCenter
        and STATE.current.paddle.dx < 0
        and not self:hasSameDxAs(STATE.current.paddle) then
        self.dx = -50 + -(8 * multiplier)
    elseif self.x > paddleCenter
        and STATE.current.paddle.dx > 0
        and not self:hasSameDxAs(STATE.current.paddle) then
        self.dx = 50 + (8 * math.abs(multiplier))
    end
end

function Ball:hasSameDxAs(object)
    return self.dx > 0 and object.dx > 0
        or self.dx < 0 and object.dx < 0
end

function Ball:hitBricks()
    for key, brick in pairs(STATE.current.map) do
        if brick.inPlay and self.hitbox:hasCollided(brick.hitbox) then
            STATE.current.player:addToScore(brick.value)
            brick:hit()
            self:bounceOffBricks(brick)

            break
        end
    end
end

function Ball:bounceOffBricks(brick)
    if self.hitbox.left + 2 < brick.hitbox.left and self.dx > 0 then
        self.x = brick.x - ATLAS.balls[self.skin].width - 2
        self.dx = -self.dx
    elseif self.hitbox.left + 6 > brick.hitbox.left + 32 and self.dx < 0 then
        self.x = brick.x + ATLAS.bricks[brick.skin].width + 2
        self.dx = -self.dx
    elseif self.hitbox.top < brick.hitbox.top then
        self.y = brick.y - ATLAS.balls[self.skin].height - 2
        self.dy = -self.dy
    else
        self.y = brick.y + ATLAS.bricks[brick.skin].height + 2
        self.dy = -self.dy
    end

    if math.abs(self.dy) < 150 then
        self.dy = self.dy * 1.2
    end

    if self.dx == 0 then
        self.dx = math.random(-50, 50)
    end
end
