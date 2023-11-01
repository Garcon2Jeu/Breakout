Hitbox = Class {}

function Hitbox:init(width, height)
    self.width  = width
    self.height = height

    self.left   = 0
    self.right  = 0
    self.top    = 0
    self.bottom = 0
end

function Hitbox:update(x, y)
    self.left   = x
    self.right  = x + self.width
    self.top    = y
    self.bottom = y + self.height
end

function Hitbox:hasCollided(foreign)
    if self.left > foreign.right or foreign.left > self.right then
        return false
    end

    if self.top > foreign.bottom or foreign.top > self.bottom then
        return false
    end

    return true
end

function Hitbox:draw()
    ASSETS.colors["setYellow"]()
    love.graphics.rectangle("line", self.left, self.top, self.width, self.height)
    ASSETS.colors["setWhite"]()
end
