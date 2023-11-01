Brick = Class {}

function Brick:init(x, y, skin)
    self.skin = skin or 1
    self.tier = 0
    self.x = x
    self.y = y
    self.hitbox = Hitbox(ATLAS.bricks[self.skin].width, ATLAS.bricks[self.skin].height)
end

function Brick:update(dt)
    self.hitbox:update(self.x, self.y)
end

function Brick:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.bricks[self.skin + self.tier].quad, self.x, self.y)
end

function Brick:setSkin(skin)
    self.skin = skin
end

function Brick:setTier(tier)
    self.tier = tier
end
