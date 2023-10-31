AssetManager = Class {}

function AssetManager:init()
    self.audio    = self:getAudio()
    self.fonts    = self:getFonts()
    self.graphics = self:getGraphics()
    self.colors   = self:getColors()
end

function AssetManager:drawBackground()
    love.graphics.draw(self.graphics["background"], 0, 0, 0,
        VIRTUAL_WIDTH / (self.graphics["background"]:getWidth() - 1),
        VIRTUAL_HEIGHT / (self.graphics["background"]:getHeight() - 1))
end

function AssetManager:getAudio()
    return {
        ["brick_hit_1"] = love.audio.newSource("assets/audio/brick_hit_1.wav", "static"),
        ["brick_hit_2"] = love.audio.newSource("assets/audio/brick_hit_2.wav", "static"),
        ["confirm"]     = love.audio.newSource("assets/audio/confirm.wav", "static"),
        ["hurt"]        = love.audio.newSource("assets/audio/hurt.wav", "static"),
        ["music"]       = love.audio.newSource("assets/audio/music.wav", "static"),
        ["no_select"]   = love.audio.newSource("assets/audio/no_select.wav", "static"),
        ["paddle_hit"]  = love.audio.newSource("assets/audio/paddle_hit.wav", "static"),
        ["pause"]       = love.audio.newSource("assets/audio/pause.wav", "static"),
        ["recover"]     = love.audio.newSource("assets/audio/recover.wav", "static"),
        ["score"]       = love.audio.newSource("assets/audio/score.wav", "static"),
        ["select"]      = love.audio.newSource("assets/audio/select.wav", "static"),
        ["victory"]     = love.audio.newSource("assets/audio/victory.wav", "static"),
        ["wall_hit"]    = love.audio.newSource("assets/audio/wall_hit.wav", "static")
    }
end

function AssetManager:getFonts()
    local small  = love.graphics.newFont("assets/fonts/font.ttf", 8)
    local medium = love.graphics.newFont("assets/fonts/font.ttf", 16)
    local large  = love.graphics.newFont("assets/fonts/font.ttf", 32)

    return {
        ["setSmall"]  = function() return love.graphics.setFont(small) end,
        ["setMedium"] = function() return love.graphics.setFont(medium) end,
        ["setLarge"]  = function() return love.graphics.setFont(large) end,
    }
end

function AssetManager:getGraphics()
    return {
        ["arrows"]       = love.graphics.newImage("assets/graphics/arrows.png"),
        ["background"]   = love.graphics.newImage("assets/graphics/background.png"),
        ["blocks"]       = love.graphics.newImage("assets/graphics/blocks.png"),
        ["breakout_big"] = love.graphics.newImage("assets/graphics/breakout_big.png"),
        ["breakout"]     = love.graphics.newImage("assets/graphics/breakout.png"),
        ["hearts"]       = love.graphics.newImage("assets/graphics/hearts.png"),
        ["particle"]     = love.graphics.newImage("assets/graphics/particle.png"),
        ["ui"]           = love.graphics.newImage("assets/graphics/ui.png"),
    }
end

function AssetManager:getColors()
    return {
        ["setBlack"]      = function() love.graphics.setColor(0, 0, 0, 1) end,
        ["setWhite"]      = function() love.graphics.setColor(1, 1, 1, 1) end,
        ["setRed"]        = function() love.graphics.setColor(1, 0, 0, 1) end,
        ["setGreen"]      = function() love.graphics.setColor(0, 1, 0, 1) end,
        ["setBlue"]       = function() love.graphics.setColor(0, 0, 1, 1) end,
        ["setPink"]       = function() love.graphics.setColor(1, 0, 1, 1) end,
        ["setCyan"]       = function() love.graphics.setColor(0, 1, 1, 1) end,
        ["setYellow"]     = function() love.graphics.setColor(1, 1, 0, 1) end,
        ["setSemiOpaque"] = function() love.graphics.setColor(1, 1, 1, .5) end,
    }
end
