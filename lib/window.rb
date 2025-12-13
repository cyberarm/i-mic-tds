module IMICTDS
  class Window < CyberarmEngine::Window
    attr_reader :server, :connection, :game

    def setup
      self.caption = format("%s (v%s) [%s]", NAME, VERSION, VERSION_NAME)

      self.update_interval = 0.001 / 60 # Only limited by v-sync
      self.show_stats_plotter = false
      self.show_cursor = true

      @server = nil
      @connection = nil
      @game = nil

      if DEVELOPMENT_MODE
        push_state(States::MainMenu)
      elsif DEBUG_QUICKPLAY
        @game = Game.new(map: nil, game_mode: nil, game_master: nil)
        start_listen_server(host: "localhost", port: IMICTDS::Networking::DEFAULT_PORT)
        push_state(States::Connecting, host: "localhost", port: IMICTDS::Networking::DEFAULT_PORT)
      else
        push_state(CyberarmEngine::IntroState, forward: States::Boot, forward_options: { forward: States::MainMenu })
      end
    end

    def update
      @server&.think
      @connection&.think

      @game&.update([inputs: :to_do])

      super
    end

    def needs_redraw?
      states.any?(&:needs_repaint?)
    end

    def start_listen_server(host:, port:, config: { maps: [], game_modes: [] })
      @server = IMICTDS::Networking::Server.new(
        host: host,
        port: port,
        channels: IMICTDS::Networking::DEFAULT_CHANNEL_COUNT,
        config: config
      )
    end

    def connect_to(host:, port:)
      @connection = IMICTDS::Networking::Connection.new(
        host: host,
        port: port,
        channels: IMICTDS::Networking::DEFAULT_CHANNEL_COUNT
      )
      @connection.connect(0)
    end
  end
end
