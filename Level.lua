local class = require 'middleclass'
local bump = require 'bump'
local sti = require 'sti'

Level = class('Level')

local function generate_collmap(world, collmap, tile_width, tile_height)
    local data = collmap.data    
    for y=1, collmap.height do
        for x=1, collmap.width do
                if (data[y][x]) then
                local x = (x-1) * tile_width
                local y = (y-1) * tile_height
                local tile = {name = 'block', x = x, y = y,
                            width = tile_width, height = tile_height}
                world:add(tile, x, y, tile_width, tile_height)
            end
        end
    end
end

function Level:initialize(filepath, world)
    local file = filepath or "map"
    assert(world)
    self.map = sti.new(file)
    self.collmap = self.map.layers['coll']
    assert(self.collmap)
    generate_collmap(world, self.collmap, 
    self.map.tilewidth, self.map.tileheight)
end

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    self.map:draw()
end

return Level
