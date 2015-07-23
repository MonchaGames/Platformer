local class = require 'middleclass'
local bump = require 'bump'
local State = require 'State/State'
local Camera = require 'Camera'
local Level = require 'Level'

require 'MakeEntity'

OverworldState = class('OverworldState', State)

function OverworldState:initialize()
    self.world = bump.newWorld(32)
    self.block = {}
    self.world:add(self.block, 0, 400, 6000, 10)
    self.level = Level:new("map", self.world)
end

function OverworldState:enter(params, parent)
    self.player = params.player or make.make_player(self.world)
    self.gun = make.make_gun(self.player)
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
    self.gun:update(dt)
    self.level:update(dt)
    if love.keyboard.isDown(' ') then
        self.parent:switch('State')
    end
end

function OverworldState:draw()
    self.camera:set()
    self.player:draw()
    self.gun:draw()
    self.level:draw()
    love.graphics.rectangle('fill', 0, 400, 6000, 10)
    self.camera:pop()
end

function OverworldState:keypressed(key)
    self.player:handle_input(key, true)
end

function OverworldState:keyreleased(key)
    self.player:handle_input(key, false)
end

return OverworldState
