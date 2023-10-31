Ball = Class {}

function Ball:init(skin)
    self.skin = skin
    self.x = 0
end

function Ball:update(dt)
end

function Ball:draw()
    love.graphics.draw(ASSETS.graphics["breakout"], ATLAS.balls[self.skin].quad,
        self.x, STATE.current.paddle.y - 20)
end

function Ball:followPaddle(paddleSkin)
    self.x = STATE.current.paddle.x + ATLAS.paddles[paddleSkin].width / 2
        - ATLAS.balls[self.skin].width / 2
end
