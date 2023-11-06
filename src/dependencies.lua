require 'src.globals'

Class = require 'src.libraries.class'
Push = require 'src.libraries.push'

require "src.App"
require "src.managers.AssetManager"
require "src.managers.AtlasManager"
require "src.managers.StateManager"
require "src.managers.MapManager"
require "src.managers.FileManager"
require "src.managers.ParticleManager"

require "src.states.BaseState"
require "src.states.StartState"
require "src.states.SelectPaddleState"
require "src.states.ScoreBoardState"
require "src.states.ServeState"
require "src.states.PlayState"
require "src.states.PauseState"
require "src.states.VictoryState"
require "src.states.OverState"
require "src.states.EnterScoreState"

require "objects.Hitbox"
require "objects.Paddle"
require "objects.Ball"
require "objects.Brick"
require "objects.PlayerStats"
