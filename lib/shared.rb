module IMICTDS
  DEVELOPMENT_MODE = ARGV.join.include?("--dev")
  DEBUG_QUICKPLAY = ARGV.join.include?("--debug-quickplay")
  ROOT_PATH = File.expand_path("..", __dir__)

  module Networking
    DEFAULT_MAX_CLIENTS = 16
    DEFAULT_CHANNEL_COUNT = 8

    DEFAULT_PORT = 56789
  end
end

if IMICTDS::DEVELOPMENT_MODE || IMICTDS::DEBUG_QUICKPLAY
  require_relative "../../ffi-enet/lib/ffi-enet"
  require_relative "../../ffi-enet/lib/ffi-enet/renet"
else
  require "ffi-enet"
  require "ffi-enet/renet"
end
require "digest/crc"

# TODO: Require CyberarmEngine::Vector and supporting classes for headless server

require_relative "version"

require_relative "ecs/entity_store"
require_relative "ecs/entity"
require_relative "ecs/component"
require_relative "ecs/components/position"
require_relative "ecs/components/velocity"
require_relative "ecs/components/render"
require_relative "ecs/system"
require_relative "ecs/systems/movement"
require_relative "ecs/systems/render"
require_relative "ecs/prefabs"

require_relative "networking/packet"
require_relative "networking/server"
require_relative "networking/connection"
require_relative "networking/packet_handler"
require_relative "networking/packet_handlers/input"

require_relative "game"
require_relative "map"
require_relative "polygon"

require_relative "game_mode"
require_relative "game_modes/bomb_detonation"
require_relative "game_modes/capture_the_flag"
require_relative "game_modes/team_deathmatch"
