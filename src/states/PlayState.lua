PlayState = Class { __includes = BaseState }

function PlayState:init() end

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball   = params.ball
    self.map    = params.map
    self.player = params.player
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:isLost() then
        self.player:removeHeart()
        STATE:change("serve", self)
    end
end

function PlayState:draw()
    MapManager:draw(self.map)
    self.paddle:draw()
    self.ball:draw()
    self.player:draw()
end

function PlayState:exit() end
