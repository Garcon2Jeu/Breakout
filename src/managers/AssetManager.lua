AssetManager = Class {}

function AssetManager:init()
    self.audio = self:getAudio()
    self.fonts = self:getFonts()
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
        ["setSmall"] = function() return love.graphics.setFont(small) end,
        ["setMedium"] = function() return love.graphics.setFont(medium) end,
        ["setLarge"] = function() return love.graphics.setFont(large) end,
    }
end
