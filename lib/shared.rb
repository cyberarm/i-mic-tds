require "digest/crc"

require_relative "version"
require_relative "networking/packet"
require_relative "networking/server"
require_relative "networking/connection"
require_relative "networking/packet_handler"
require_relative "networking/packet_handlers/input"
require_relative "game"
require_relative "game_mode"
require_relative "game_modes/bomb_detonation"
require_relative "game_modes/capture_the_flag"
require_relative "game_modes/team_deathmatch"