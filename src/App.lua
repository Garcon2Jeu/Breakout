App = Class {}

function App:init()
    math.randomseed(os.time())
    self:setWindow()
    self.keysPressed = {}

    self.file = FileManager()
end

function App:update(dt)
    self:restart()
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

function App:restart()
    if self:wasKeyPressed("backspace") then
        love.load()
    end
end

function App:slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        table.insert(sliced, tbl[i])
    end

    return sliced
end

function App:flipCoin(low, high)
    return math.random(low, high) == 1 and true or false
end
