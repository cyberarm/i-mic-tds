module IMICTDS
  class States
    class Play < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        @label = tagline "PING: 0ms\nMTU: 0", margin: 16
        @label2 = tagline "MS: 0ms", margin: 16
      end

      def update
        super

        @label.value = "PING: #{window.connection&.client&.last_round_trip_time}ms\n" \
                       "MTU: #{window.connection&.client&._peer[:mtu]}"

        @label2.value = format("Time: %.3f s\nTotal packets: %d", window.game&.time || -1, window.connection&.client&.total_sent_packets + window.connection&.client&.total_received_packets)
      end

      def draw
        super
      end
    end
  end
end
