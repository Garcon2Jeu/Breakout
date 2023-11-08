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

    self:updatePowerUps(dt)
    self:addPowerUp()
    self:remove()
end

function PowerUpManager:draw()
    if #self.inPlay < 1 then
        return
    end

    for key, powerUp in pairs(self.inPlay) do
        powerUp:draw()
    end
end

function PowerUpManager:updatePowerUps(dt)
    for key, powerUp in pairs(self.inPlay) do
        powerUp:update(dt)
    end
end

function PowerUpManager:addPowerUp()
    for index, powerUp in ipairs(self.inPlay) do
        if powerUp.hitbox:hasCollided(STATE.current.paddle.hitbox) then
            powerUp.power = powerUp:getPower()
            powerUp.power()
            powerUp.power = nil

            self.inPlay[index] = nil
        end
    end
end

function PowerUpManager:remove()
    for index, powerUp in ipairs(self.inPlay) do
        if powerUp.y > VIRTUAL_HEIGHT then
            table.remove(self.inPlay, index)
        end
    end
end
