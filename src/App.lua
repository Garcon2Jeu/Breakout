App = Class {}

function App:init()
    math.randomseed(os.time())
    self:setWindow()
    self.keysPressed = {}
end

function App:update(dt)
    self:quit()
    self:flushKeys()
end

function App:setWindow()
    love.window.setTitle("Breakout - Project")
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resize = false,
        vsync = true
    })
end

function App:wasKeyPressed(key)
    return self.keysPressed[key]
end

function App:flushKeys()
    self.keysPressed = {}
end

function App:quit()
    if self:wasKeyPressed("escape") then
        love.event.quit()
    end
end
