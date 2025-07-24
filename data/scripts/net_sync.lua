-- data/scripts/net_sync.lua
local net_sync = {}

function net_sync:is_connected()
  return true
end

function net_sync:get_remote_players()
  return {
    { id = 2, name = "Player2", x = 172, y = 176 }
  }
end

function net_sync:update()
  -- Stub: would send player position to server and sync others
end

return net_sync
