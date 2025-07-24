-- data/scripts/multi_hero.lua
local multi_hero = {}

function multi_hero:start(game)
  self.game = game
  self.heroes = { game:get_hero() }
  self.player_count = 1

  -- assign joypad controllers
  for i = 2,4 do
    local joy = sol.joystick.get_joystick(i - 1)
    if joy then
      local hero = require("scripts/multi_hero").create_player(game, i)
      table.insert(self.heroes, hero)
      self.player_count = self.player_count + 1
    end
  end

  game:set_max_lives(4)
  -- setup HUD icons, tunics
  for i, hero in ipairs(self.heroes) do
    hero:set_tunic_sprite_id("hero/tunic" .. i)
  end
end

function multi_hero.create_player(game, id)
  local hero = game:create_hero{id = id}
  return hero
end

function multi_hero:get_num_heroes_on(sensor_name, map)
  local count = 0
  for _, hero in ipairs(self.heroes) do
    if hero:is_near(sensor_name) then count = count + 1 end
  end
  return count
end

return multi_hero
