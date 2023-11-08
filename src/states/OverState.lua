OverState = Class { __includes = BaseState }


local topChoice = true


function OverState:enter(params)
    self.player = params.player
end

function OverState:update(dt)
    if APP:wasKeyPressed("up") or APP:wasKeyPressed("down") then
        ASSETS.audio["select"]:play()
        topChoice = not topChoice
    end

    if not APP:wasKeyPressed("return") then
        return
    end

    ASSETS.audio["confirm"]:play()

    if topChoice then
        STATE:change("start")
    end

    if self.player:hasHighScore() then
        STATE:change("enterScore", self.player.score)
        return
    end

    STATE:change("scoreBoard")
end

function OverState:draw()
    ASSETS.fonts["setLarge"]()
    love.graphics.printf("GAME OVER", 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")


    ASSETS.fonts["setSmall"]()
    love.graphics.printf("Level: " .. tostring(self.player.level), 0, CENTER_HEIGHT - 5, VIRTUAL_WIDTH, "center")
    love.graphics.printf("Final Score: " .. tostring(self.player.score), 0, CENTER_HEIGHT + 5, VIRTUAL_WIDTH, "center")


    ASSETS.fonts["setMedium"]()
    if topChoice then
        ASSETS.colors["setYellow"]()
    end

    local string = self.player:hasHighScore() and "Enter High Score" or "Score Board"
    love.graphics.printf(string, 0, CENTER_HEIGHT + 20, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()


    if not topChoice then
        ASSETS.colors["setYellow"]()
    end

    love.graphics.printf("Start Again", 0, CENTER_HEIGHT + 40, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()
end