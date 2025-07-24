-- data/maps/four_swords/dungeon1.lua
local map = ...
local game = map:get_game()
local multi_hero = require("scripts/multi_hero")

function map:on_started()
  local sensor = map:get_entity("sensor_switch_1")
  if sensor then
    sensor.on_activated = function()
      if multi_hero:get_num_heroes_on("sensor_switch_1", map) >= 2 then
        map:open_door("door_1")
      end
    end
  end

  local warp = map:get_entity("to_boss_warp")
  if warp then
    warp.on_activated = function()
      sol.audio.play_sound("warp")
      game:start_transition("four_swords/boss_room", "from_dungeon")
    end
  end
end
