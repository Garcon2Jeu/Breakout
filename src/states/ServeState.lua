ServeState = Class { __includes = BaseState }

function ServeState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.map = params.map
    self.player = params.player
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball:followPaddle(self.paddle.skin)

    if APP:wasKeyPressed("space") then
        STATE:change("play", self)
    end
end

function ServeState:draw()
    self.paddle:draw()
    self.ball:draw()
    MapManager:draw(self.map)
    self.player:draw()
end

function ServeState:exit() end
