PlayerStats = Class {}

local maxHearts = 3

function PlayerStats:init()
    self.score     = 0
    self.hearts    = 3
    self.energy    = 0
    self.energyMax = 1000


    self.level       = 1

    self.maxRows     = 3
    self.maxColumns  = 7

    self.highestSkin = 1
    self.highestTier = 0
    self.lowestSkin  = 1
    self.lowestTier  = 0
end

function PlayerStats:update(dt)
    self:recoverHeart()
end

function PlayerStats:draw()
    love.graphics.print("Level " .. tostring(self.level), 10, 6)
    self:drawHearts()
    self:drawScore()
    self:drawEnergyBar()
end

function PlayerStats:drawEnergyBar()
    local width     = 100
    local height    = 6
    local x         = CENTER_WIDTH - (width / 2)
    local y         = 4

    local fillWidth = self.energy * (width / self.energyMax)

    ASSETS.colors["setGreen"]()
    love.graphics.rectangle("fill", x, y, fillWidth, height)

    ASSETS.colors["setBlack"]()
    love.graphics.rectangle("line", x, y, width, height)

    ASSETS.colors["setWhite"]()
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
    self.energy = self.energy + value
end

function PlayerStats:removeHeart()
    self.hearts = self.hearts - 1
end

function PlayerStats:recoverHeart()
    if self.energy < self.energyMax then
        return
    end

    self.energy = self.energy - self.energyMax
    self.hearts = self.hearts + 1 > 3 and 3 or self.hearts + 1

    if self.hearts == 3 then
        self:addToScore(200)
    end
end

function PlayerStats:increaseLevel()
    self.level      = self.level + 1
    self.energyMax  = self.energyMax + 250
    self.maxColumns = self.maxColumns + 2

    if self.maxColumns > 13 then
        self.maxRows = self.maxRows + 1 > 7 and 7 or self.maxRows + 1
        self.maxColumns = 7
    end

    self:changeBricks()
end

function PlayerStats:changeBricks()
    if self.highestSkin == 17 then
        return
    end

    self.highestTier = self.highestTier + 1
    self.lowestTier = self.highestTier - 1

    if self.highestTier > 3 then
        self.highestTier = 0
        self.lowestTier = 0
        self.highestSkin = self.highestSkin + 4
    end

    if self.highestSkin == 13 or self.highestSkin == 17 then
        self.lowestSkin = self.lowestSkin + 4
    end
end

function PlayerStats:hasHighScore()
    local highScores = FileManager:load()

    for key, listing in pairs(highScores) do
        if self.score > tonumber(listing.score) then
            return true
        end
    end

    return false
end
