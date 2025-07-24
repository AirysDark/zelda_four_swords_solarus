-- data/enemies/bat.lua
local enemy = ...

function enemy:on_created()
  self:set_life(1)
  self:set_damage(1)
  self:create_sprite("enemies/bat")
  self:set_size(16, 16)
  self:set_origin(8, 8)
  self:set_can_hurt_hero_running(true)
end

function enemy:on_restarted()
  local m = sol.movement.create("random")
  m:set_speed(64)
  m:start(self)
end
