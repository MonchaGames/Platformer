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
    self.special = Entity.special
end

function GunGraphicsComponent:draw()
    if (self.special == "hit") then
        love.graphics.setColor(255, 0, 0, 255)
    end
   love.graphics.rectangle('fill', self.x, self.y, self.width, self.height) 
   love.graphics.setColor(255, 255, 255, 255)
end

GunInputComponent = class("GunInputComponent")

function GunInputComponent:initialize(Entity, world)
    assert(Entity, "Guns must track an entity") 
    self.parent = Entity
    self.world = world
end

function GunInputComponent:update(dt, Entity)
    Entity.direction = self.parent.direction
    if (self.parent.direction == 0) then
        Entity.x = self.parent.x + 50
    elseif (self.parent.direction == 1) then
        Entity.x = self.parent.x - 10
    end

    if love.keyboard.isDown("v") then
        self:fire(Entity.x, Entity.y, Entity.direction, Entity) 
    end
    Entity.y = self.parent.y
end

function GunInputComponent:fire(x, y, direction, Entity)
    local bullet = {name = "bullet", x = x, y = y}
    self.world:add(bullet, x, y, 5, 5)
    
    local goal_x = 0
    if direction == 0 then
        goal_x = goal_x + 1000         
    elseif direction == 1 then
        goal_x = goal_x - 1000
    end
    
    local actual_x, actual_y, cols, len = self.world:move(bullet, goal_x, y)
    
    if len > 0 then
        Entity.special = "hit" 
    else
        Entity.special = ""
    end

    self.world:remove(bullet)
end

function GunInputComponent:handle_input(key, is_pressed)

end

