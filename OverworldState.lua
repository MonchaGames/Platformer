local class = require 'middleclass'
local bump = require 'bump'
local State = require 'State/State'
local Camera = require 'Camera'

require 'MakeEntity'

OverworldState = class('OverworldState', State)

function OverworldState:initialize()
    self.world = bump.newWorld(32)
    self.block = {}
    self.world:add(self.block, 0, 400, 6000, 10)
end

function OverworldState:enter(params, parent)
    self.player = params.player or make.make_player(self.world)
    self.parent = parent
    self.camera = Camera:new(self.player)
end

function OverworldState:return_params()
    params = {}
    params.player = self.player
    return params
end

function OverworldState:update(dt)
    self.camera:update(dt)
    self.player:update(dt)
    if love.keyboard.isDown(' ') then
        self.parent:switch('State')
    end
end

function OverworldState:draw()
    self.player:draw()
    love.graphics.rectangle('fill', 0, 400, 6000, 10)
end

function OverworldState:keypressed(key)
    self.player:handle_input(key, true)
end

function OverworldState:keyreleased(key)
    self.player:handle_input(key, false)
end

return OverworldState
