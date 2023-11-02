MapManager = Class {}

local maxRows = 5
local maxColumns = 13
local minRows = 1
local minColumns = 7

local skins = { 1, 5, 9, 13, 17 }

function MapManager:factory(highestSkin, highestTier, lowestSkin, lowestTier)
    local map = {}

    local rows = 3
    local columns = 7
    columns = columns % 2 == 0 and columns + 1 or columns

    local highestSkin = highestSkin or 3
    local highestTier = highestTier or 0
    local lowestSkin = lowestSkin or 1
    local lowestTier = lowestTier or 0

    local solidSkin = 2
    local solidTier = 0

    for column = 1, rows do
        local skipRow = APP:flipCoin()
        local skipColumn = APP:flipCoin()

        local alternatePattern = APP:flipCoin()
        local alternateBrick = APP:flipCoin()

        for row = 1, columns do
            if skipRow and skipColumn then
                skipColumn = not skipColumn
                goto continue
            else
                skipColumn = not skipColumn
            end

            local brick = self:makeBrick(8, row - 1, columns, column)
            brick:setSkin(skins[lowestSkin])
            brick:setTier(lowestTier)

            if alternatePattern and alternateBrick then
                brick:setSkin(skins[highestSkin])
                brick:setTier(highestTier)
                alternateBrick = not alternateBrick
            else
                alternateBrick = not alternateBrick
            end

            if not alternatePattern then
                brick:setSkin(skins[solidSkin])
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

function MapManager:draw(map)
    for key, brick in pairs(map) do
        brick:draw()
    end
end
