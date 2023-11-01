Ball = Class {}

local SPEED = 75

function Ball:init(skin)
    self.skin = skin
    self.x = 0
    self.y = STATE.current.paddle.y - 20
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
end

function Ball:draw()
    love.graphics.draw(ASSETS.graphics["breakout"],
        ATLAS.balls[self.skin].quad, self.x, self.y)
    -- self.hitbox:draw()
end

function Ball:followPaddle(paddleSkin)
    self.x = STATE.current.paddle.x + ATLAS.paddles[paddleSkin].width / 2
        - ATLAS.balls[self.skin].width / 2
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:clamp()
    if self.dy < 0 and self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        return
    end

    if self.dy > 0 and self.y + ATLAS.balls[self.skin].width >= VIRTUAL_HEIGHT then
        self.y = VIRTUAL_HEIGHT - ATLAS.balls[self.skin].width
        self.dy = -self.dy
        return
    end

    if self.dx < 0 and self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        return
    end

    if self.dx > 0 and self.x + ATLAS.balls[self.skin].width >= VIRTUAL_WIDTH then
        self.x = VIRTUAL_WIDTH - ATLAS.balls[self.skin].width
        self.dx = -self.dx
        return
    end
end

function Ball:bounceOffPaddle()
    if self.hitbox:hasCollided(STATE.current.paddle.hitbox) then
        self.y  = STATE.current.paddle.y - ATLAS.balls[self.skin].height
        self.dy = -self.dy
    end
end

function Ball:hitBricks()
    for key, brick in pairs(STATE.current.map) do
        if brick.inPlay and self.hitbox:hasCollided(brick.hitbox) then
            brick:destroy()
            self:bounceOffBricks(brick)

            break
        end
    end
end

function Ball:bounceOffBricks(brick)
    if self.hitbox.left + 2 < brick.hitbox.left and self.dx > 0 then
        self.x = brick.x - ATLAS.balls[self.skin].width
        self.dx = -self.dx
    elseif self.hitbox.left + 6 > brick.hitbox.left + 32 and self.dx < 0 then
        self.x = brick.x + ATLAS.bricks[brick.skin].width
        self.dx = -self.dx
    elseif self.hitbox.top < brick.hitbox.top then
        self.y = brick.y - ATLAS.balls[self.skin].height
        self.dy = -self.dy
    else
        self.y = brick.y + ATLAS.bricks[brick.skin].height
        self.dy = -self.dy
    end

    if math.abs(self.dy) < 150 then
        self.dy = self.dy * 1.3
    end

    if self.dx == 0 then
        self.dx = math.random(-20, 20)
    end
end
