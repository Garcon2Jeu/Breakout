ScoreBoardState = Class { __includes = BaseState }

function ScoreBoardState:update(dt)
    if APP:wasKeyPressed("backspace") then
        STATE:change("start")
    end
end

function ScoreBoardState:draw()
    ASSETS.fonts["setMedium"]()
    local y = 15
    for index, data in ipairs(APP.file:load()) do
        love.graphics.printf(tostring(index) .. ". " .. data.name .. " = " .. data.score, 0, y, VIRTUAL_WIDTH, "center")
        y = y + 20
    end
    ASSETS.fonts["setSmall"]()
    love.graphics.printf("Press Backspace to Title Screen", 0, y + 15, VIRTUAL_WIDTH, "center")
end
