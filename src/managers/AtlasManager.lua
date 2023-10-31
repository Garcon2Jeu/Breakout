AtlasManager = Class {}

local x = 0

function AtlasManager:init()
    self.paddles = self:getPaddles()
    self.x = 0
end

function AtlasManager:draw()
    -- local y = -100

    -- for i = 1, #self.paddles do
    --     love.graphics.draw(ASSETS.graphics["breakout"], self.paddles[1], 50, y)
    --     y = y + 20
    -- end
end

function AtlasManager:getPaddles(y)
    local paddles = {}

    for j = 0, 3 do
        local y     = 64 + (32 * j)
        local x     = 0
        local width = 32

        for i = 1, 4 do
            table.insert(paddles, love.graphics.newQuad(x, y, width, 16, ASSETS.graphics["breakout"]))

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
