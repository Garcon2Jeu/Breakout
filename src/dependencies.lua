require 'src.globals'

Class = require 'src.libraries.class'
Push = require 'src.libraries.push'

require "src.App"
require "src.managers.AssetManager"
require "src.managers.AtlasManager"
require "src.managers.StateManager"
require "src.managers.MapManager"

require "src.states.BaseState"
require "src.states.StartState"
require "src.states.SelectPaddleState"
require "src.states.ServeState"
require "src.states.PlayState"

require "objects.Paddle"
require "objects.Ball"
require "objects.Brick"
