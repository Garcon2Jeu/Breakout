PowerUp = Class {}

local GRAVITY = 50

function PowerUp:init(skin, x, y)
    self.skin   = skin
    self.x      = x - (ATLAS.powerUps[5]["width"] / 2)
    self.y      = y - (ATLAS.powerUps[5]["height"] / 2)
    self.hitbox = Hitbox(
        self.x, self.y,
        ATLAS.powerUps[self.skin]["width"],
        ATLAS.powerUps[self.skin]["height"]
    )
end

function PowerUp:update(dt)
    self.y = self.y + 50 * dt
    self.hitbox:update(self.x, self.y)
end

function PowerUp:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.powerUps[self.skin]["quad"], self.x, self.y)

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self.hitbox:draw()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

function PowerUp:usePower()
    if self.skin == 5 then
        STATE.current.paddle:upgrade()
    end

    if self.skin == 9 then
        STATE.current.balls:multiply(2)
    end
end
