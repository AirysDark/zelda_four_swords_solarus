-- data/maps/title_screen.lua
local map = ...
local game = map:get_game()

function map:on_started()
  sol.audio.play_music("title")
  sol.menu.start(map, require("scripts/title_menu"))
end
