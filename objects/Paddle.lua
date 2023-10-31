Paddle = Class {}

local SPEED = 200

function Paddle:init(skin)
    self.skin = skin
    self.x    = CENTER_WIDTH - ATLAS.paddles[self.skin].width / 2
    self.y    = VIRTUAL_HEIGHT - 40
    self.dx   = 0
end

function Paddle:update(dt)
    self:move(dt)
end

function Paddle:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.paddles[self.skin].quad, self.x, self.y)
end

function Paddle:move(dt)
    if love.keyboard.isDown("right") then
        self.dx = SPEED
    elseif love.keyboard.isDown("left") then
        self.dx = -SPEED
    else
        self.dx = 0
    end

    self.x = self.x + self.dx * dt
end
