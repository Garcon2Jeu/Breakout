MapManager = Class {}

local maxRows = 5
local maxColumns = 13
local minRows = 3
local minColumns = 7

local skins = { 1, 5, 9, 13, 17 }

function MapManager:factory(player)
    local map = {}

    local rows = player.maxRows
    local columns = player.maxColumns

    for column = 1, rows do
        local skipRow = APP:flipCoin(1, 2)
        local skipColumn = APP:flipCoin(1, 2)

        local alternatePattern = APP:flipCoin(1, 2)
        local alternateBrick = APP:flipCoin(1, 2)

        local solidSkin = math.random(player.lowestSkin, player.highestSkin)
        local solidTier = math.random(player.lowestTier, player.highestTier)

        for row = 1, columns do
            if skipRow and skipColumn then
                skipColumn = not skipColumn
                goto continue
            else
                skipColumn = not skipColumn
            end

            local brick = self:makeBrick(8, row - 1, columns, column)

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
