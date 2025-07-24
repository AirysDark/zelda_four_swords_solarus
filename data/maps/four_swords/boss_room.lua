-- data/maps/four_swords/boss_room.lua
local map = ...
local game = map:get_game()

function map:on_started()
  local boss = map:get_entity("boss_knight")
  local door = map:get_entity("boss_door")

  if boss then
    boss:register_event("on_dead", function()
      map:open_door("boss_door")
      sol.audio.play_sound("secret")
    end)
  end

  if door then
    map:close_doors("boss_door")
  end

  local warp = map:get_entity("return_warp")
  if warp then
    warp.on_activated = function()
      sol.audio.play_sound("warp")
      game:start_transition("four_swords/dungeon1", "boss_exit")
    end
  end
end
