-- Map script for hub level to detect player entry into stairs zone and show glow

local map = ...
local game = map:get_game()

function map:on_started()
  check_start_zone()
  show_stair_glow()
end

function show_stair_glow()
  local glow = map:create_custom_entity({
    name = "stair_glow",
    x = 104, y = 8, layer = 0, width = 16, height = 16,
    direction = 0,
    sprite = "entities/glow_tile"
  })
  glow:get_sprite():set_animation("glow")
end

function check_start_zone()
  local sensor = map:get_entity("stair_start_zone")
  if not sensor then return end

  sol.timer.start(map, 500, function()
    local in_zone = true
    for i = 1, 4 do
      local hero = game:get_hero(i)
      if hero and not sensor:overlaps(hero) then
        in_zone = false
      end
    end
    if in_zone then
      sol.audio.play_sound("secret")
      sol.timer.start(map, 1000, function()
        local level = game:get_value("next_level") or "forest_ruins"
        game:save()
        game:start_dialog("Starting " .. level .. "!")
        sol.timer.start(map, 1000, function()
          game:change_map("maps/levels/" .. level .. ".dat")
        end)
      end)
      return false
    end
    return true
  end)
end
