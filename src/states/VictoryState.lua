VictoryState = Class {}

function VictoryState:enter(params)
    self.player = params.player
    self.paddle = params.paddle
end

function VictoryState:update(dt)
    if APP:wasKeyPressed("return") then
        ASSETS.audio["confirm"]:play()

        self.player:increaseLevel()
        self.map = MapManager:factory(self.player)
        self.ball = Ball()

        STATE:change("serve", self)
    end
end

function VictoryState:draw()
    ASSETS.fonts["setLarge"]()
    love.graphics.printf("LEVEL " .. tostring(self.player.level) .. " Completed!", 0,
        CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")

    ASSETS.fonts["setSmall"]()
    love.graphics.printf("Current Score: " .. tostring(self.player.score), 0, CENTER_HEIGHT + 5, VIRTUAL_WIDTH, "center")

    ASSETS.fonts["setMedium"]()
    ASSETS.colors["setYellow"]()
    love.graphics.printf("Press Enter to continue", 0, CENTER_HEIGHT + 20, VIRTUAL_WIDTH, "center")
    ASSETS.fonts["setSmall"]()
end

function VictoryState:exit() end
