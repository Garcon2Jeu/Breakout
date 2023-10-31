require 'src.globals'

Class = require 'src.libraries.class'
Push = require 'src.libraries.push'

require "src.App"
require "src.managers.AssetManager"
require "src.managers.AtlasManager"
require "src.managers.StateManager"

require "src.states.BaseState"
require "src.states.StartState"
require "src.states.SelectPaddleState"
require "src.states.ServeState"

require "objects.Paddle"
require "objects.Ball"
