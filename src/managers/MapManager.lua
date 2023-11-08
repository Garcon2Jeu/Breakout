MapManager = Class {}

local maxRows = 5
local maxColumns = 13
local minRows = 3
local minColumns = 7

local skins = { 1, 5, 9, 13, 17 }

function MapManager:factory(player)
    local map = {}

    for column = 1, player.maxRows do
        local skipRow = APP:flipCoin(1, 2)
        local skipColumn = APP:flipCoin(1, 2)

        local alternatePattern = APP:flipCoin(1, 2)
        local alternateBrick = APP:flipCoin(1, 2)

        local solidSkin = math.random(player.lowestSkin, player.highestSkin)
        local solidTier = math.random(player.lowestTier, player.highestTier)

        for row = 1, player.maxColumns do
            if skipRow and skipColumn then
                skipColumn = not skipColumn
                goto continue
            else
                skipColumn = not skipColumn
            end

            local brick = self:makeBrick(8, row - 1, player.maxColumns, column)

            brick:setSkin(player.lowestSkin)
            brick:setTier(player.highestTier)

            if alternatePattern and alternateBrick then
                brick:setSkin(player.highestSkin)
                brick:setTier(0)
            end

            alternateBrick = not alternateBrick

            if not alternatePattern then
                brick:setSkin(solidSkin)
                brick:setTier(solidTier)
            end

            table.insert(map, brick)
            ::continue::
        end
    end

    map = self:insertPowerUps(map)

    return map
end

function MapManager:makeBrick(x, row, columns, column)
    return Brick(
        x + (row * ATLAS.bricks[1].width) + (maxColumns - columns) * ATLAS.bricks[1].width / 2,
        (column) * 16
    )
end

function MapManager:update(dt, map)
    for key, brick in pairs(map) do
        brick:update(dt)
    end
end

function MapManager:draw(map)
    for key, brick in pairs(map) do
        brick:draw()
    end
end

function MapManager:insertPowerUps(map, ball, paddle)
    local ballPowerUp = ball or false
    local paddlePowerUp = paddle or false

    for index, brick in ipairs(map) do
        if not brick.powerUp and math.random(1, #map) == index then
            if not ballPowerUp then
                brick.powerUp = 9
                ballPowerUp = true
            else
                brick.powerUp = 5
                paddlePowerUp = true
            end
        end
    end

    if not ballPowerUp or not paddlePowerUp then
        self:insertPowerUps(map, ballPowerUp, paddlePowerUp)
    end

    return map
end
