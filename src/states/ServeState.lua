ServeState = Class { __includes = BaseState }

function ServeState:init()
    self.ball = Ball(1)
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball:followPaddle(self.paddle.skin)
end

function ServeState:draw()
    self.paddle:draw()
    self.ball:draw()
end

function ServeState:enter(params)
    self.paddle = Paddle(params)
end

function ServeState:exit() end
