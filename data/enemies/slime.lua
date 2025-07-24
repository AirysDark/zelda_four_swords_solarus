-- data/enemies/slime.lua
local enemy = ...

function enemy:on_created()
  self:set_life(2)
  self:set_damage(1)
  self:create_sprite("enemies/slime")
  self:set_size(16, 16)
  self:set_origin(8, 13)
  self:set_pushed_back_when_hurt(true)
end

function enemy:on_restarted()
  local m = sol.movement.create("random_path")
  m:set_speed(32)
  m:start(self)
end
