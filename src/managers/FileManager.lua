FileManager = Class {}

function FileManager:init()
    love.filesystem.setIdentity("breakout")

    if not love.filesystem.getInfo("breakout.txt") then
        self:addFillerScores()
    end
end

-- function FileManager:write()
--     love.filesystem.write("scoreBoard.txt", "test")
-- end

function FileManager:addFillerScores()
    local scoreString = ""

    for i = 1, 10 do
        scoreString = scoreString .. "AAA\n" .. tostring(i * 1000) .. "\n"
    end

    love.filesystem.write("breakout.txt", scoreString)
end

local function compareScore(a, b)
    return tonumber(a.score) > tonumber(b.score)
end

function FileManager:load()
    local scores = {}
    local counter = 1
    local isName = true

    local name = ''
    local score = ''

    for line in love.filesystem.lines("breakout.txt") do
        if isName then
            name = line
            isName = false
        else
            score = line
            counter = counter + 1
            isName = true

            table.insert(scores, { name = name, score = score })
        end
    end

    table.sort(scores, compareScore)
    return scores
end
