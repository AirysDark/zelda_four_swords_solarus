-- data/enemies/archer.lua
local enemy = ...

function enemy:on_created()
  self:set_life(3)
  self:set_damage(2)
  self:create_sprite("enemies/archer")
  self:set_size(16, 16)
  self:set_origin(8, 13)
  self:set_attack_consequence("sword", 1)
end

function enemy:on_restarted()
  self:check_hero()
end

function enemy:check_hero()
  local hero = self:get_map():get_hero()
  local angle = self:get_angle(hero)
  self:get_sprite():set_direction(angle)
  sol.timer.start(self, 1500, function()
    self:shoot_arrow()
    self:check_hero()
  end)
end

function enemy:shoot_arrow()
  local arrow = self:create_enemy{
    name = "arrow",
    breed = "projectile",
    x = 0, y = 0, layer = self:get_layer()
  }
end
