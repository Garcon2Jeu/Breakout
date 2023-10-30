App = Class {}

function App:init()
    math.randomseed(os.time())
    self:setWindow()
    self.keyspressed = {}
end

function App:update(dt)
    self:quit()
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
    return self.keyspressed[key]
end

function App:quit()
    if self:wasKeyPressed("escape") then
        love.event.quit()
    end
end
