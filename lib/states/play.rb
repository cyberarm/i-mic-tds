module IMICTDS
  class States
    class Play < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        @label = tagline "Pending...", margin: 16
        @sample = {
          _time: -1.0,
          packets_a: 0,
          packets_b: 0,
          bytes_a: 0,
          bytes_b: 0
        }
      end

      def update
        super

        return unless (client = window.connection&.client)

        @label.value = format(
                                "Game Time: %.3f s\n\nPing: %dms\nAvg Ping: %dms\nMTU: %d\nTotal packets: %d\nTotal Data: %s\nPacket loss: %.2f%%\n\nPackets per second: %d\nData per second: %s",
                                window.game&.time || -1,
                                client.round_trip_time,
                                client.last_round_trip_time,
                                client._peer[:mtu],
                                client.total_sent_packets + client.total_received_packets,
                                IMICTDS.format_byte_size(client.total_sent_data + client.total_received_data),
                                client.packet_loss,
                                @sample[:packets_b] - @sample[:packets_a],
                                IMICTDS.format_byte_size(@sample[:bytes_b] - @sample[:bytes_a])
                              )

        if window.game && window.game.time - @sample[:_time] >= 1.0 # second
          @sample[:_time] = window.game.time
          @sample[:packets_a] = @sample[:packets_b]
          @sample[:packets_b] = client.total_sent_packets + client.total_received_packets

          @sample[:bytes_a] = @sample[:bytes_b]
          @sample[:bytes_b] = client.total_sent_data + client.total_received_data
        end
      end

      def draw
        super
      end
    end
  end
end
