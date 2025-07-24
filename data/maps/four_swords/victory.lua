-- data/maps/four_swords/victory.lua
local map = ...
local game = map:get_game()

function map:on_started()
  sol.audio.stop_music()
  sol.timer.start(map, 500, function()
    sol.audio.play_music("victory")
  end)

  sol.timer.start(map, 1000, function()
    game:start_dialog("game.victory", function()
      sol.menu.start(map, require("scripts/victory_menu"))
    end)
  end)
end
