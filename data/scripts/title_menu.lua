-- data/scripts/title_menu.lua
local title_menu = {}

function title_menu:on_started()
  self.surface = sol.surface.create(320, 240)
  self.background = sol.surface.create("hud/title_background.png")
  self.logo = sol.surface.create("sprites/title/logo.png")
  self.logo_y = -40
  self.options = {"Start Game", "Load Save 1", "Load Save 2", "Quit"}
  self.selected = 1
  self.font = sol.text_surface.create({
    font = "minecraftia",
    font_size = 12,
    color = {255, 255, 0}
  })
  self.info_font = sol.text_surface.create({
    font = "minecraftia",
    font_size = 8,
    color = {255, 255, 255}
  })
  self:load_save_info()
  self:animate_logo()
end

function title_menu:load_save_info()
  self.save_info = {
    [2] = "Empty",
    [3] = "Empty"
  }

  for i = 1, 2 do
    local slot = "save" .. i .. ".dat"
    if sol.game.exists(slot) then
      local game = sol.game.load(slot)
      local hearts = game:get_max_life() / 4
      local play_time = game:get_time_played()
      self.save_info[i + 1] = string.format("❤️ %.0f Hearts, 🕒 %d sec", hearts, play_time)
    end
  end
end

function title_menu:animate_logo()
  sol.timer.start(self, 16, function()
    if self.logo_y < 20 then
      self.logo_y = self.logo_y + 1
      return true
    end
  end)
end

function title_menu:on_draw(dst_surface)
  self.background:draw(dst_surface)
  self.logo:draw(dst_surface, 40, self.logo_y)

  for i, text in ipairs(self.options) do
    self.font:set_text((i == self.selected and "> " or "  ") .. text)
    self.font:draw(dst_surface, 100, 120 + i * 20)
    if self.save_info[i] then
      self.info_font:set_text(self.save_info[i])
      self.info_font:draw(dst_surface, 100, 120 + i * 20 + 14)
    end
  end
end

function title_menu:on_key_pressed(key)
  if key == "up" then
    self.selected = (self.selected - 2) % #self.options + 1
  elseif key == "down" then
    self.selected = self.selected % #self.options + 1
  elseif key == "space" or key == "return" then
    local choice = self.options[self.selected]
    if choice == "Start Game" then
      sol.main:start_savegame("save1.dat")
    elseif choice == "Load Save 1" then
      sol.main:start_savegame("save1.dat")
    elseif choice == "Load Save 2" then
      sol.main:start_savegame("save2.dat")
    elseif choice == "Quit" then
      sol.main.exit()
    end
  end
end

return title_menu
