-- NPC script: level_selector.lua

local map = ...
local game = map:get_game()

function map:on_interaction(npc)
  if npc:get_name() == "npc_level_selector" then
    game:start_dialog("level_selector_1", function()
      game:start_dialog("level_selector_2.question", function(answer)
        if answer == 1 then
          game:start_dialog("level_selector_3_forest", function()
            confirm_level("forest_ruins")
          end)
        elseif answer == 2 then
          game:start_dialog("level_selector_3_ice", function()
            confirm_level("ice_cavern")
          end)
        elseif answer == 3 then
          game:start_dialog("level_selector_3_fire", function()
            confirm_level("fire_temple")
          end)
        end
      end)
    end)
  end
end

function confirm_level(level_name)
  game:start_dialog("level_selector_confirm.question", function(confirm)
    if confirm == 1 then
      game:set_value("next_level", level_name)
      sol.audio.play_sound("ok")
      sol.timer.start(map, 500, function()
        game:start_dialog("All players must stand on the top stairs to begin.")
      end)
    end
  end)
end
