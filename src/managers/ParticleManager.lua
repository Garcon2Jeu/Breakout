ParticleManager = Class {}

local palette = {
    [1]  = { r = 99, g = 155, b = 255 },
    [5]  = { r = 106, g = 190, b = 47 },
    [9]  = { r = 217, g = 87, b = 99 },
    [13] = { r = 215, g = 123, b = 186 },
    [17] = { r = 251, g = 242, b = 54 }
}


function ParticleManager:init()
    self.system = love.graphics.newParticleSystem(ASSETS.graphics["particle"], 1000)
    self.system:setParticleLifetime(.5, 1)
    self.system:setSizeVariation(1)
    self.system:setEmissionArea("uniform", 18, 10)
    self.system:setLinearAcceleration(0, 50, 0, 50)
end

function ParticleManager:update(dt)
    self.system:update(dt)
end

function ParticleManager:draw(x, y)
    love.graphics.draw(self.system, x, y)
end

function ParticleManager:emit(color)
    self.system:setColors(
        palette[color].r / 255, palette[color].g / 255, palette[color].b / 255, 120,
        palette[color].r / 255, palette[color].g / 255, palette[color].b / 255, 0
    )
    self.system:emit(100)
end

function ParticleManager:stop()
    self.system:stop()
end
