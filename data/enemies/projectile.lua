-- data/enemies/projectile.lua
local enemy = ...

function enemy:on_created()
  self:set_life(1)
  self:set_damage(2)
  self:create_sprite("enemies/projectile")
  self:set_size(8, 8)
  self:set_origin(4, 4)
  self:set_invincible()
  self:set_attack_consequence("sword", "protected")
end

function enemy:on_restarted()
  local direction = self:get_sprite():get_direction() or 0
  local m = sol.movement.create("straight")
  m:set_angle(math.pi / 2 * direction)
  m:set_speed(128)
  m:set_max_distance(160)
  m:set_ignore_obstacles(true)
  m:start(self, function() self:remove() end)
end

function enemy:on_obstacle_reached()
  self:remove()
end

function enemy:on_attacking_hero(hero)
  hero:start_hurt(self, self:get_damage())
  self:remove()
end
