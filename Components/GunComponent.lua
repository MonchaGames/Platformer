local class = require 'middleclass'
local Timer = require 'timer'

require 'misc'

GunGraphicsComponent = class("GunGraphicsComponent")

function GunGraphicsComponent:initialize()
    self.x = 0
    self.y = 0
    self.width = 10
    self.height = 10
end

function GunGraphicsComponent:update(dt, Entity)
    assert(type(Entity) == 'table')

    self.x = Entity.x
    self.y = Entity.y
end

function GunGraphicsComponent:draw()
   love.graphics.rectangle('fill', self.x, self.y, self.width, self.height) 
end

GunInputComponent = class("GunInputComponent")

function GunInputComponent:initialize(Entity)
    assert(Entity, "Guns must track an entity") 
    self.parent = Entity
end

function GunInputComponent:update(dt, Entity)
    if (self.parent.direction == 0) then
        Entity.x = self.parent.x + 50
    elseif (self.parent.direction == 1) then
        Entity.x = self.parent.x - 10
    end

    Entity.y = self.parent.y
end

function GunInputComponent:handle_input(key, is_pressed)

end

