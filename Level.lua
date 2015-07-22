local class = require 'middleclass'
local bump = require 'bump'
local sti = require 'sti'

Level = class('Level')

function Level:initialize(filepath, world)
    local file = filepath or "map"
    assert(world)
    self.map = sti.new(file)

    for k, v in pairs(self.map.layers) do
        print(k)
    end
end

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    self.map:draw()
end

