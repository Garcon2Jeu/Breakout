PlayState = Class { __includes = BaseState }

function PlayState:enter(params)
    self.paddle = params.paddle
    self.balls  = params.balls
    self.map    = params.map
    self.player = params.player
end

function PlayState:update(dt)
    MapManager:update(dt, self.map)
    self.paddle:update(dt)

    for key, ball in pairs(self.balls) do
        ball:update(dt)
    end

    self.player:update(dt)

    if not self:ballsInPlay() then
        ASSETS.audio["hurt"]:play()
        self.player:removeHeart()
        self.balls = { Ball() }

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

    for key, ball in pairs(self.balls) do
        ball:draw()
    end

    self.player:draw()
end

function PlayState:checkVictory()
    for key, brick in pairs(self.map) do
        if brick.inPlay then
            return false
        end
    end

    return true
end

function PlayState:ballsInPlay()
    for key, ball in pairs(self.balls) do
        if ball.inPlay then
            return true
        end
    end

    return false
end
