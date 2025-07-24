-- data/scripts/pause_menu.lua
local pause_menu = {}

function pause_menu:on_started()
  self.surface = sol.surface.create(320, 240)
  self.options = { "Resume", "Return to Title", "Quit Game" }
  self.selected = 1
  self.font = sol.text_surface.create{
    font = "minecraftia",
    font_size = 12,
    color = {255, 255, 255}
  }
end

function pause_menu:on_draw(dst_surface)
  self.surface:clear()
  for i, option in ipairs(self.options) do
    local text = (i == self.selected and "> " or "  ") .. option
    self.font:set_text(text)
    self.font:draw(self.surface, 90, 100 + i * 20)
  end
  self.surface:draw(dst_surface)
end

function pause_menu:on_key_pressed(key)
  if key == "up" then
    self.selected = (self.selected - 2) % #self.options + 1
  elseif key == "down" then
    self.selected = self.selected % #self.options + 1
  elseif key == "space" or key == "return" then
    local choice = self.options[self.selected]
    if choice == "Resume" then
      sol.menu.stop(self)
    elseif choice == "Return to Title" then
      sol.menu.stop(self)
      require("scripts/game_manager"):show_title_screen()
    elseif choice == "Quit Game" then
      sol.menu.stop(self)
      sol.main.exit()
    end
  end
end

return pause_menu
