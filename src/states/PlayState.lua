PlayState = Class { __includes = BaseState }

function PlayState:init() end

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball   = params.ball
    self.map    = params.map
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)
end

function PlayState:draw()
    MapManager:draw(self.map)
    self.paddle:draw()
    self.ball:draw()
end

function PlayState:exit() end
