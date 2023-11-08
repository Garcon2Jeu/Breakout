ServeState = Class { __includes = BaseState }

function ServeState:enter(params)
    self.paddle = params.paddle
    self.balls = params.balls
    self.map = params.map
    self.player = params.player
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.balls[1]:followPaddle(self.paddle.skin)

    if APP:wasKeyPressed("space") then
        ASSETS.audio["serve"]:play()
        STATE:change("play", self)
    end
end

function ServeState:draw()
    self.paddle:draw()
    self.balls[1]:draw()
    MapManager:draw(self.map)
    self.player:draw()
end

function ServeState:exit() end
