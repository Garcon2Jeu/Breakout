Paddle = Class {}

local SPEED = 200
local upgradeOffset = 16

function Paddle:init(skin)
    self.skin   = skin
    self.x      = CENTER_WIDTH - ATLAS.paddles[self.skin].width / 2
    self.y      = VIRTUAL_HEIGHT - 30
    self.dx     = 0
    self.hitbox = Hitbox(self.x, self.y,
        ATLAS.paddles[self.skin].width,
        ATLAS.paddles[self.skin].height)
end

function Paddle:update(dt)
    self.dx = self:changeDx()
    self.x  = self:move(dt)
    self.x  = self:clamp(dt)
    self.hitbox:update(
        self.x, self.y,
        ATLAS.paddles[self.skin].width,
        ATLAS.paddles[self.skin].height)
end

function Paddle:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.paddles[self.skin].quad, self.x, self.y)

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self.hitbox:draw()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
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

function Paddle:upgrade()
    if self.skin < 4 then
        self.skin = self.skin + 1
        self.x = self.x - upgradeOffset
    end
end

function Paddle:downgrade()
    if not self.skin == 0 then
        self.skin = self.skin - 1
        self.x = self.x + upgradeOffset
    end
end
