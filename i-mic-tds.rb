begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/version"
require_relative "lib/theme"
require_relative "lib/window"
require_relative "lib/networking/packet"
require_relative "lib/networking/server"
require_relative "lib/networking/connection"
require_relative "lib/networking/packet_handler"
require_relative "lib/networking/packet_handlers/input"
require_relative "lib/game"
require_relative "lib/game_mode"
require_relative "lib/game_modes/bomb_detonation"
require_relative "lib/game_modes/capture_the_flag"
require_relative "lib/game_modes/team_deathmatch"
require_relative "lib/states/boot"
require_relative "lib/states/main_menu"
require_relative "lib/states/server_browser"

IMICTDS::Window.new(width: 1280, height: 720, resizable: true).show
