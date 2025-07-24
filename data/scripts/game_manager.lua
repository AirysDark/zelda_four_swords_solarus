-- data/scripts/game_manager.lua
local game_manager = {}

function game_manager:show_title_screen()
  sol.main:start_map("title_screen")
end

function game_manager:start_game(slot)
  local game = sol.game.load(slot or "save1.dat") or sol.game.create(slot or "save1.dat")

  function game:on_paused()
    sol.menu.start(game, require("scripts/pause_menu"))
  end

  game:start()
end

return game_manager
