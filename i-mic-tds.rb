begin
  require_relative "../../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require_relative "lib/shared"

require_relative "lib/theme"
require_relative "lib/window"
require_relative "lib/states/boot"
require_relative "lib/states/main_menu"
require_relative "lib/states/server_browser"

IMICTDS::Window.new(width: 1280, height: 720, resizable: true).show
