Brick = Class {}

function Brick:init(x, y)
    self.x = x
    self.y = y
end

function Brick:update(dt) end

function Brick:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.bricks[1].quad, self.x, self.y)
end
