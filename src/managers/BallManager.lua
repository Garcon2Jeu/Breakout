BallManager = Class {}

function BallManager:init(skin)
    self.skin = skin or 1
    self.inPlay = { Ball(self.skin) }
end

function BallManager:update(dt)
    for key, ball in pairs(self.inPlay) do
        ball:update(dt)
    end

    self:remove()
end

function BallManager:draw()
    for index, ball in ipairs(self.inPlay) do
        ball:draw()
    end
end

function BallManager:followPaddle(paddleSkin)
    self.inPlay[1].x = STATE.current.paddle.x + ATLAS.paddles[paddleSkin]["width"] / 2
        - ATLAS.balls[self.inPlay[1].skin]["width"] / 2
end

function BallManager:remove()
    for index, ball in ipairs(self.inPlay) do
        if ball:isLost() then
            table.remove(self.inPlay, index)
        end
    end
end

function BallManager:allLost()
    return #self.inPlay < 1
end

function BallManager:multiply(amount)
    for i = 1, amount do
        table.insert(self.inPlay,
            Ball(
                self.skin,
                self.inPlay[1].x,
                self.inPlay[1].y,
                self.inPlay[1].dx + math.random(-20, 20)
            )
        )
        ASSETS.audio["ball_upgrade"]:play()
    end
end
