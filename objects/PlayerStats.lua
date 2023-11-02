PlayerStats = Class {}

local maxHearts = 3

function PlayerStats:init()
    self.level = 1
    self.score = 0
    self.hearts = 3
end

function PlayerStats:update(dt) end

function PlayerStats:draw()
    love.graphics.print("Level " .. tostring(self.level), 10, 6)
    self:drawHearts()
    self:drawScore()
end

function PlayerStats:drawHearts()
    for i = 1, self.hearts do
        love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.hearts[1].quad,
            VIRTUAL_WIDTH - 100 + (ATLAS.hearts[1].width * (i - 1)), 5)
    end

    for i = 1, maxHearts - self.hearts do
        love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.hearts[2].quad,
            VIRTUAL_WIDTH - 80 - (ATLAS.hearts[1].width * (i - 1)), 5)
    end
end

function PlayerStats:drawScore()
    ASSETS.fonts["setSmall"]()
    love.graphics.print("SCORE:", VIRTUAL_WIDTH - 65, 6)
    love.graphics.printf(tostring(self.score), VIRTUAL_WIDTH - 60, 6, 50, "right")
end

function PlayerStats:addToScore(value)
    self.score = self.score + value
end

function PlayerStats:removeHeart()
    self.hearts = self.hearts - 1
end
