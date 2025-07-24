-- data/enemies/boss_knight.lua
local enemy = ...

function enemy:on_created()
  self:set_life(20)
  self:set_damage(4)
  self:create_sprite("enemies/boss_knight")
  self:set_size(32, 32)
  self:set_origin(16, 29)
  self.phase = 1
end

function enemy:on_restarted()
  if self.phase == 1 then
    self:start_phase_one()
  elseif self.phase == 2 then
    self:start_phase_two()
  end
end

function enemy:start_phase_one()
  local m = sol.movement.create("target")
  m:set_target(self:get_map():get_hero())
  m:set_speed(40)
  m:start(self)
end

function enemy:start_phase_two()
  local m = sol.movement.create("random_path")
  m:set_speed(72)
  m:start(self)

  sol.timer.start(self, 2000, function()
    self:shoot_projectile()
    return true
  end)
end

function enemy:on_hurt()
  if self:get_life() <= 10 and self.phase == 1 then
    self.phase = 2
    self:stop_movement()
    self:restart()
  end
end

function enemy:shoot_projectile()
  local map = self:get_map()
  map:create_enemy({
    breed = "projectile",
    x = self:get_position(),
    layer = self:get_layer(),
    direction = self:get_sprite():get_direction(),
    name = "boss_projectile"
  })
end
