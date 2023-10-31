AtlasManager = Class {}

function AtlasManager:init()
    self.atlas   = ASSETS.graphics["breakout"]
    self.bricks  = self:getBricks()
    self.balls   = self:getBalls()
    self.hearts  = self:getHearts()
    self.paddles = self:getPaddles()
end

function AtlasManager:draw()
    ------------------------------ DRAW ALL BRICKS-------------------------------------
    -- local x = 10
    -- local y = 10
    -- for i = 1, #self.bricks do
    --     love.graphics.draw(self.atlas, self.bricks[i], x, y)
    --     x = x + 40

    --     if x >= VIRTUAL_WIDTH - 32 then
    --         x = 10
    --         y = y + 20
    --     end
    -- end
    ------------------------------------------------------------------------------------

    ------------------------------ DRAW ALL BALLS-------------------------------------
    -- local x = 10
    -- local y = 10

    -- for i = 1, #self.balls do
    --     love.graphics.draw(self.atlas, self.balls[i], x, y)
    --     x = x + 10

    --     if x >= VIRTUAL_WIDTH - 10 then
    --         x = 10
    --         y = y + 10
    --     end
    -- end
    ------------------------------------------------------------------------------------

    -- love.graphics.draw(self.atlas, self.hearts[1], 10, 10)
end

function AtlasManager:getEvenQuads(tileWidth, tileHeight)
    local sheetWidth  = self.atlas:getWidth() / tileWidth
    local sheetHeight = self.atlas:getHeight() / tileHeight


    local bricks = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            table.insert(bricks,
                love.graphics.newQuad(x * tileWidth, y * tileHeight,
                    tileWidth, tileHeight, self.atlas))
        end
    end

    return bricks
end

function AtlasManager:getBricks()
    local tiledAtlas = self:getEvenQuads(32, 16)
    local bricks = APP:slice(tiledAtlas, nil, 21)
    table.insert(bricks, APP:slice(tiledAtlas, 24, 24)[1])

    return bricks
end

function AtlasManager:getBalls()
    local tiledAtlas = self:getEvenQuads(8, 8)
    local balls = App:slice(tiledAtlas, 157, 160)
    local toAdd = App:slice(tiledAtlas, 181, 183)

    for key, ball in pairs(toAdd) do
        table.insert(balls, ball)
    end

    return balls
end

function AtlasManager:getHearts()
    return {
        love.graphics.newQuad(128, 48, 10, 10, self.atlas),
        love.graphics.newQuad(138, 48, 10, 10, self.atlas),
    }
end

function AtlasManager:getPaddles()
    local paddles = {}

    for j = 0, 3 do
        local y     = 64 + (32 * j)
        local x     = 0
        local width = 32

        for i = 1, 4 do
            table.insert(paddles, love.graphics.newQuad(x, y, width, 16, self.atlas))

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
