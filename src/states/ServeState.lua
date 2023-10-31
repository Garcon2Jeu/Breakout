ServeState = Class { __includes = BaseState }

function ServeState:init()
    self.ball = Ball(1)
    self.map = MapManager:factory()
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
end

function ServeState:enter(params)
    self.paddle = Paddle(params)
end

function ServeState:exit() end
