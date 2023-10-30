StateManager = Class {}

function StateManager:init(states)
    self.empty = {
        update = function(dt) end,
        draw   = function() end,
        enter  = function(params) end,
        exit   = function() end,
    }
    self.states = states or {}
    self.current = self.empty
end

function StateManager:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

function StateManager:update(dt)
    self.current:update(dt)
end

function StateManager:draw()
    self.current:draw()
end

function StateManager:switchTo(stateName, enterParams)
    assert(self.states[stateName])
    self.placeholder = self.current
    self:change(stateName, enterParams)
end

function StateManager:switchBack()
    self.current:exit()
    self.current = self.placeholder
end
