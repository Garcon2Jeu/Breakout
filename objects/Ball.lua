Ball = Class {}

local SPEED = 100

function Ball:init(skin)
    self.skin = skin
    self.x = 0
    self.y = STATE.current.paddle.y - 20
    self.dx = -60
    self.dy = -SPEED
    self.hitbox = Hitbox(ATLAS.balls[self.skin].width, ATLAS.balls[self.skin].height)
end

function Ball:update(dt)
    self:move(dt)
    self.hitbox:update(self.x, self.y)
    self:clamp()
    self:bounceOffPaddle()
end

function Ball:draw()
    love.graphics.draw(ASSETS.graphics["breakout"],
        ATLAS.balls[self.skin].quad, self.x, self.y)
    self.hitbox:draw()
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
