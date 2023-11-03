Brick = Class {}

function Brick:init(x, y, skin)
    self.skin = skin or 1
    self.tier = 0
    self.x = x
    self.y = y
    self.hitbox = Hitbox(self.x, self.y,
        ATLAS.bricks[self.skin].width, ATLAS.bricks[self.skin].height)

    self.inPlay = true
end

function Brick:update(dt)
    if self.inPlay then
        self.hitbox:update(self.x, self.y)
    end
end

function Brick:draw()
    if self.inPlay then
        love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.bricks[self.skin + self.tier].quad, self.x, self.y)

        ------------------------------------------------------DEBUG-------------------------------------------------------------------
        -- self.hitbox:draw()
        ------------------------------------------------------DEBUG-------------------------------------------------------------------
    end
end

function Brick:setSkin(skin)
    self.skin = skin
    self.value = (self.skin + self.tier) * 25
end

function Brick:setTier(tier)
    self.tier = tier
    self.value = (self.skin + self.tier) * 25
end

function Brick:destroy()
    self.inPlay = false
    STATE.current.player:addToScore(self.value)
end
