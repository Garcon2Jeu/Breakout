AssetManager = Class {}

function AssetManager:init()
    self.audio = self:getAudio()
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
