AtlasManager = Class {}

function AtlasManager:init()
    self.atlas    = ASSETS.graphics["breakout"]
    self.bricks   = self:getBricks()
    self.balls    = self:getBalls()
    self.hearts   = self:getHearts()
    self.paddles  = self:getPaddles()
    self.powerUps = self:getPowerUps()
    self.arrows   = self:getArrows()
end

function AtlasManager:getQuad(x, y, width, height, atlas)
    return {
        ["width"] = width,
        ["height"] = height,
        ["quad"] = love.graphics.newQuad(x, y, width, height, atlas)
    }
end

function AtlasManager:getEvenQuads(tileWidth, tileHeight, atlas)
    local sheetWidth  = self.atlas:getWidth() / tileWidth
    local sheetHeight = self.atlas:getHeight() / tileHeight


    local bricks = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            table.insert(bricks,
                self:getQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, atlas))
        end
    end

    return bricks
end

function AtlasManager:getBricks()
    local tiledAtlas = self:getEvenQuads(32, 16, self.atlas)
    local bricks = APP:slice(tiledAtlas, nil, 21)
    table.insert(bricks, APP:slice(tiledAtlas, 24, 24)[1])

    return bricks
end

function AtlasManager:getBalls()
    local tiledAtlas = self:getEvenQuads(8, 8, self.atlas)
    local balls = App:slice(tiledAtlas, 157, 160)
    local toAdd = App:slice(tiledAtlas, 181, 183)

    for key, ball in pairs(toAdd) do
        table.insert(balls, ball)
    end

    return balls
end

function AtlasManager:getHearts()
    return {
        self:getQuad(128, 48, 10, 10, self.atlas),
        self:getQuad(138, 48, 10, 10, self.atlas),
    }
end

function AtlasManager:getPaddles()
    local paddles = {}

    for j = 0, 3 do
        local y     = 64 + (32 * j)
        local x     = 0
        local width = 32

        for i = 1, 4 do
            table.insert(paddles, self:getQuad(x, y, width, 16, self.atlas))

            x = x + (32 * i)
            width = width + 32

            if i == 3 then
                x = 0
                y = y + 16
            end
        end
    end

    return paddles
end

function AtlasManager:getPowerUps()
    return App:slice(self:getEvenQuads(16, 16, self.atlas), 145, 154)
end

function AtlasManager:getArrows()
    return self:getEvenQuads(24, 24, ASSETS.graphics["arrows"])
end
