PowerUpManager = Class {}

function PowerUpManager:init()
    self.inPlay = {}
end

function PowerUpManager:spawn(x, y)
    table.insert(self.inPlay, PowerUp(5, x, y))
end

function PowerUpManager:update(dt)
    if #self.inPlay < 1 then
        return
    end

    self:updateBalls(dt)
    self:addPowerUp()
end

function PowerUpManager:draw()
    if #self.inPlay < 1 then
        return
    end

    for key, powerUp in pairs(self.inPlay) do
        powerUp:draw()
    end
end

function PowerUpManager:updateBalls(dt)
    for key, powerUp in pairs(self.inPlay) do
        powerUp:update(dt)
    end
end

function PowerUpManager:addPowerUp()
    for index, powerUp in ipairs(self.inPlay) do
        if powerUp.hitbox:hasCollided(STATE.current.paddle.hitbox) then
            self.inPlay[index] = nil
            STATE.current.paddle:upgrade()
        end
    end
end
