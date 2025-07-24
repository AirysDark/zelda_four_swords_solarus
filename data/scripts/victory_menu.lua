-- data/scripts/victory_menu.lua
local victory_menu = {}

function victory_menu:on_started()
  self.surface = sol.surface.create(320, 240)
  self.font = sol.text_surface.create({
    font = "minecraftia",
    font_size = 16,
    horizontal_alignment = "center",
    vertical_alignment = "middle"
  })
  self.font:set_text("Victory!\nThanks for playing.\nPress Enter for credits.")
end

function victory_menu:on_draw(dst_surface)
  self.surface:clear()
  self.font:draw(self.surface, 160, 120)
  self.surface:draw(dst_surface)
end

function victory_menu:on_key_pressed(key)
  if key == "space" or key == "return" then
    sol.menu.start(self, require("scripts/credits"))
  end
end

return victory_menu
