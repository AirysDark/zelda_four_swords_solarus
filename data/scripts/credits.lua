-- data/scripts/credits.lua
local credits = {}

function credits:on_started()
  self.surface = sol.surface.create(320, 240)
  self.text = sol.text_surface.create{
    font = "minecraftia",
    font_size = 10,
    color = {255, 255, 255}
  }
  self.lines = {
    "Four Swords: Solarus Edition",
    "",
    "Developed by AirysDark",
    "Engine: Solarus",
    "Sprites & Maps: Custom / Placeholder",
    "",
    "Thanks for playing!",
    "",
    "Press Start to return to title."
  }
  self.scroll_y = 240
  sol.audio.play_music("credits")
end

function credits:on_draw(dst_surface)
  self.surface:clear()
  for i, line in ipairs(self.lines) do
    self.text:set_text(line)
    self.text:draw(self.surface, 160, self.scroll_y + i * 16)
  end
  self.surface:draw(dst_surface)
end

function credits:on_update()
  self.scroll_y = self.scroll_y - 0.5
end

function credits:on_key_pressed(key)
  if key == "space" or key == "return" then
    sol.main.reset()
  end
end

return credits
