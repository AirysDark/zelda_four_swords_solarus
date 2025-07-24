-- data/scripts/combat.lua
local combat = {}

function combat:initialize(hero)
  hero:register_event("on_state_changed", function(_, state)
    if state == "sword loading finished" then
      hero:start_attack()
    end
  end)

  hero:register_event("on_attack_released", function()
    -- Future: Add custom effects or particles
  end)
end

function hero:start_attack()
  local sword_sprite = hero:get_sprite("sword")
  if not sword_sprite then
    hero:create_sprite("hero/sword")
  end
  hero:set_invincible(true, 500)
  -- Temporarily show sword animation or hitbox here
end

return combat
