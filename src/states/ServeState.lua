ServeState = Class { __includes = BaseState }

function ServeState:init()

end

function ServeState:update(dt)
    self.paddle:update(dt)
end

function ServeState:draw()
    self.paddle:draw()
end

function ServeState:enter(params)
    self.paddle = Paddle(params)
end

function ServeState:exit() end
