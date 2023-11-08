Hitbox = Class {}

function Hitbox:init(x, y, width, height)
    self.width  = width
    self.height = height

    self.left   = x
    self.right  = x + self.width
    self.top    = y
    self.bottom = y + self.height
end

function Hitbox:update(x, y, width, height)
    self.width  = width or self.width
    self.height = height or self.height

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

-- function Hitbox:hasCollidedLeft(foreign)
--     if self.right > foreign.left then
--         return true
--     end

--     return false
-- end

-- function Hitbox:hasCollidedRight(foreign)
--     if self.left < foreign.right then
--         return true
--     end

--     return false
-- end

-- function Hitbox:hasCollidedTop(foreign)
--     if self.bottom > foreign.top then
--         return true
--     end

--     return false
-- end

-- function Hitbox:hasCollidedBottom(foreign)
--     if self.top < foreign.bottom then
--         return true
--     end

--     return false
-- end
