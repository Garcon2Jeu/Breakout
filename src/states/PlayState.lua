PlayState = Class { __includes = BaseState }

function PlayState:enter(params)
    self.paddle   = params.paddle
    self.balls    = params.balls
    self.map      = params.map
    self.player   = params.player

    self.powerUps = PowerUpManager()
end

function PlayState:update(dt)
    MapManager:update(dt, self.map)
    self.paddle:update(dt)
    self.balls:update(dt)
    self.player:update(dt)
    self.powerUps:update(dt)

    if self.balls:allLost() then
        ASSETS.audio["hurt"]:play()
        self.player:removeHeart()
        self.balls = BallManager()

        STATE:change("serve", self)
    end

    if self.player.hearts < 1 then
        STATE:change("over", self)
    end

    if self:checkVictory() then
        ASSETS.audio["victory"]:play()
        STATE:change("victory", self)
    end

    if APP:wasKeyPressed("space") then
        ASSETS.audio["pause"]:play()
        STATE:switchTo("pause", self)
    end
end

function PlayState:draw()
    MapManager:draw(self.map)
    self.paddle:draw()
    self.balls:draw()
    self.player:draw()
    self.powerUps:draw()
end

function PlayState:checkVictory()
    for key, brick in pairs(self.map) do
        if brick.inPlay then
            return false
        end
    end

    return true
end

-- function PlayState:ballsInPlay()
--     for key, ball in pairs(self.balls) do
--         if not ball.inPlay then
--             table.remove(self.balls, key)
--             return false
--         end
--     end

--     return true
-- end

-- function PlayState:multiplyBall(amount)
--     for i = 0, amount do
--         table.insert(self.balls, Ball(1, self.balls[1].x, self.balls[1].y))
--     end
-- end
