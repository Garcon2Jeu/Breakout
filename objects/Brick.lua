Brick = Class {}

function Brick:init(x, y, skin, powerUp)
    self.skin = skin or 1
    self.tier = 0
    self.x = x
    self.y = y
    self.hitbox = Hitbox(self.x, self.y,
        ATLAS.bricks[self.skin]["width"], ATLAS.bricks[self.skin]["height"])

    self.inPlay = true
    self.particles = ParticleManager()
    self.powerUp = powerUp or nil
    self.locked = false
end

function Brick:update(dt)
    self.particles:update(dt)

    if self.inPlay then
        self.hitbox:update(self.x, self.y)
    end
end

function Brick:draw()
    if self.inPlay then
        love.graphics.draw(ASSETS.graphics["breakout"],
            ATLAS.bricks[self.skin + self.tier]["quad"], self.x, self.y)

        ------------------------------------------------------DEBUG-------------------------------------------------------------------
        -- self.hitbox:draw()
        ------------------------------------------------------DEBUG-------------------------------------------------------------------
    end

    self.particles:draw(
        self.x + ATLAS.bricks[self.skin]["width"] / 2,
        self.y + ATLAS.bricks[self.skin]["height"] / 2)
end

function Brick:setSkin(skin)
    self.skin = skin
    self:updateValue()
end

function Brick:setTier(tier)
    self.tier = tier
    self:updateValue()
end

function Brick:updateValue()
    self.value = (self.skin + self.tier) * 25
end

function Brick:hit()
    if self.locked then
        ASSETS.audio["brick_locked"]:play()
        return
    end

    ASSETS.audio["brick_hit_2"]:play()

    STATE.current.player:addToScore(self.value)

    if self.tier > 0 then
        self.tier = self.tier - 1
        return
    else
        self.tier = 0
        self.skin = self.skin - 4
    end

    self:updateValue()

    if self.skin < 1 and self.tier == 0 then
        self.skin = 1
        self:destroy()

        if self.powerUp then
            STATE.current.powerUps:spawn(
                self.x + (ATLAS.bricks[self.skin]["width"] / 2),
                self.y + (ATLAS.bricks[self.skin]["height"] / 2),
                self.powerUp
            )
        end
    end
end

function Brick:destroy()
    ASSETS.audio["brick_hit_1"]:play()
    self.inPlay = false
    self.particles:emit(self.skin)
end

function Brick:lock()
    self.locked = true
    self.placeholder = self.skin
    self.skin = 22
end

function Brick:unlock()
    if self.locked then
        self.locked = false
        self.skin = self.placeholder
        self.placeholder = nil
        ASSETS.audio["unlock_brick"]:play()
    end
end
