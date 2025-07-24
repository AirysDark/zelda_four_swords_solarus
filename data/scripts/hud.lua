-- data/scripts/hud.lua
local hud = {}
local heart_icons = {
  full = sol.surface.create("hud/heart_full.png"),
  half = sol.surface.create("hud/heart_half.png"),
  empty = sol.surface.create("hud/heart_empty.png")
}
local name_font = sol.text_surface.create{
  font = "minecraftia",
  font_size = 10,
  color = {255, 255, 255}
}

function hud:initialize(game)
  self.game = game
  self.surface = sol.surface.create(320, 240)
  self.heroes = {
    { name = "Player 1", x = 10, y = 10, hero = game:get_hero() },
    -- You can expand this with hero2, hero3, etc. once linked
  }
end

local function draw_hearts(dst_surface, life, max_life, x, y)
  local hearts = math.floor(max_life / 4)
  local remaining = life
  for i = 0, hearts - 1 do
    local heart_x = x + i * 12
    if remaining >= 4 then
      heart_icons.full:draw(dst_surface, heart_x, y)
    elseif remaining == 3 then
      heart_icons.half:draw(dst_surface, heart_x, y)
      heart_icons.empty:draw(dst_surface, heart_x + 1, y)
    elseif remaining == 2 then
      heart_icons.half:draw(dst_surface, heart_x, y)
    elseif remaining == 1 then
      heart_icons.half:draw(dst_surface, heart_x, y)
    else
      heart_icons.empty:draw(dst_surface, heart_x, y)
    end
    remaining = remaining - 4
  end
end

function hud:on_draw(dst_surface)
  for i, player in ipairs(self.heroes) do
    local x, y = player.x, player.y
    local life = player.hero:get_life()
    local max_life = player.hero:get_max_life()
    draw_hearts(dst_surface, life, max_life, x, y)
    name_font:set_text(player.name)
    name_font:draw(dst_surface, x + 50, y)
  end
end

return hud
