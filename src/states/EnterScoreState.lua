EnterScoreState = Class { __includes = BaseState }

function EnterScoreState:init()
    self.chars = { 65, 65, 65 }
    self.highlighted = 1
end

function EnterScoreState:enter(params)
    self.score = params
end

function EnterScoreState:update(dt)
    self:selectLetter()
    self:selectChar()

    if APP:wasKeyPressed("return") then
        local name = string.char(self.chars[1]) .. string.char(self.chars[2]) .. string.char(self.chars[3])
        FileManager:replaceHighScore(name, self.score)

        STATE:change("scoreBoard")
    end
end

function EnterScoreState:draw()
    ASSETS.fonts["setSmall"]()
    love.graphics.printf("Enter name with arrow keys", 0, CENTER_HEIGHT - 70, VIRTUAL_WIDTH, "center")

    ASSETS.fonts["setLarge"]()

    if self.highlighted == 1 then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf(string.char(self.chars[1]), 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH - 40, "center")
    ASSETS.colors["setWhite"]()


    if self.highlighted == 2 then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf(string.char(self.chars[2]), 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH, "center")
    ASSETS.colors["setWhite"]()


    if self.highlighted == 3 then
        ASSETS.colors["setYellow"]()
    end
    love.graphics.printf(string.char(self.chars[3]), 0, CENTER_HEIGHT - 48, VIRTUAL_WIDTH + 40, "center")
    ASSETS.colors["setWhite"]()

    ASSETS.fonts["setSmall"]()
    love.graphics.printf("Press enter to confirm", 0, CENTER_HEIGHT, VIRTUAL_WIDTH, "center")
end

function EnterScoreState:selectLetter()
    if APP:wasKeyPressed("right") then
        self.highlighted = self.highlighted + 1 > 3 and 1 or self.highlighted + 1
    elseif APP:wasKeyPressed("left") then
        self.highlighted = self.highlighted - 1 < 1 and 3 or self.highlighted - 1
    end
end

function EnterScoreState:selectChar()
    if APP:wasKeyPressed("down") then
        self.chars[self.highlighted] = self.chars[self.highlighted] + 1 > 90 and 65 or self.chars[self.highlighted] + 1
    elseif APP:wasKeyPressed("up") then
        self.chars[self.highlighted] = self.chars[self.highlighted] - 1 < 65 and 90 or self.chars[self.highlighted] - 1
    end
end
