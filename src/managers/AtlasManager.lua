AtlasManager = Class {}

function AtlasManager:init()
    self.atlas = ASSETS.graphics["breakout"]
    self.bricks = self:getBricks()
    self.paddles = self:getPaddles()
end

function AtlasManager:draw()
    local x = 10
    local y = 10

    -- for key, brick in pairs(self.bricks) do
    --     love.graphics.draw(self.atlas, brick, 10, y)
    --     y = y + 20
    -- end
    -- love.graphics.draw(self.atlas, self.bricks[5], x, y)

    -- for i = 1, 21 do
    --     love.graphics.draw(self.atlas, self.bricks[i], x, y)
    --     x = x + 40

    --     if x >= VIRTUAL_WIDTH - 32 then
    --         x = 10
    --         y = y + 20
    --     end
    -- end

    -- love.graphics.draw(self.atlas, self.bricks[3], 10, y)
end

function AtlasManager:getEvenQuads(tileWidth, tileHeight)
    local sheetWidth  = self.atlas:getWidth() / tileWidth
    local sheetHeight = self.atlas:getHeight() / tileHeight


    local bricks = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            table.insert(bricks,
                love.graphics.newQuad(x * tileWidth, y * tileHeight,
                    tileWidth, tileHeight, self.atlas:getDimensions()))
        end
    end

    return bricks
end

function AtlasManager:getBricks()
    return APP:slice(self:getEvenQuads(32, 16), nil, 21)
end

function AtlasManager:getPaddles(y)
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
