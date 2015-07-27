local Entity = require 'Entity'
local PlayerComponent = require 'Components/PlayerComponent'
local GunComponent = require 'Components/GunComponent'

make = {}

function make.make_player(world)
    assert(world, "Need to provide bump world!")
    return Entity:new(PlayerGraphicsComponent:new(),
    PlayerInputComponent:new(),
    PlayerPhysicsComponent:new(world))
end

function make.make_gun(player, world)
    
    return Entity:new(GunGraphicsComponent:new(), GunInputComponent:new(player, world))
end

