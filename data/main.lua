-- data/main.lua
local game_manager = require("scripts/game_manager")

function sol.main:on_started()
  sol.video.set_mode(320, 240)
  game_manager:show_title_screen()
end
