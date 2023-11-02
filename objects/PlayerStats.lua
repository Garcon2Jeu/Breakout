PlayerStats = Class {}

local maxHearts = 3

function PlayerStats:init()
    self.level = 1
    self.score = 0
    self.hearts = 3
end

function PlayerStats:update(dt) end

function PlayerStats:draw()
    self:drawHearts()
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
