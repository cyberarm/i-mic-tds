module IMICTDS
  class States
    class Play < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        @label = tagline "PING: 0ms", margin: 16
      end

      def update
        super

        @label.value = "PING: #{window.connection&.client&.last_round_trip_time}ms\n" \
                       "MTU: #{window.connection&.client&._peer[:mtu]}"
      end

      def draw
        super
      end
    end
  end
end
