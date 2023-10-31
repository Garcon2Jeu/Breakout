Paddle = Class {}

local SPEED = 200

function Paddle:init(skin)
    self.skin = skin
    self.x    = CENTER_WIDTH - ATLAS.paddles[self.skin].width / 2
    self.y    = VIRTUAL_HEIGHT - 30
    self.dx   = 0
end

function Paddle:update(dt)
    self.dx = self:changeDx()
    self.x  = self:move(dt)
    self.x  = self:clamp(dt)
end

function Paddle:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.paddles[self.skin].quad, self.x, self.y)
end

function Paddle:changeDx()
    if love.keyboard.isDown("right") then
        return SPEED
    elseif love.keyboard.isDown("left") then
        return -SPEED
    else
        return 0
    end
end

function Paddle:move(dt)
    return self.x + self.dx * dt
end

function Paddle:clamp(dt)
    return self.dx < 0
        and math.max(0, self.x)
        or math.min(self.x, VIRTUAL_WIDTH - ATLAS.paddles[self.skin].width)
end
