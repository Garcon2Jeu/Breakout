App = Class {}

function App:init()
    self:setWindow()
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
