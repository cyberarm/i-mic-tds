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

        return unless window.game && window.game.time - @sample[:_time] >= 1.0 # second

        @sample[:_time] = window.game.time
        @sample[:packets_a] = @sample[:packets_b]
        @sample[:packets_b] = client.total_sent_packets + client.total_received_packets

        @sample[:bytes_a] = @sample[:bytes_b]
        @sample[:bytes_b] = client.total_sent_data + client.total_received_data
      end

      def draw
        super

        window.game&.map&.draw
      end

      def draw_map(_map)
        # Map background
        Gosu.draw_rect(0, 0, context.window.width, context.window.height, 0xff_26a269)

        Gosu.translate(-@offset.x, -@offset.y) do
          Gosu.scale(@zoom, @zoom, context.window.width / 2, context.window.height / 2) do
            # TODO: Map play area
            @play_area.each(&:draw)

            # TODO: Map obstructions
            @obstructions.each(&:draw)

            # TODO: Map game elements
            @entities.each(&:draw)
          end

          return unless edit_mode?

          # Map grid
          y_start = (@offset.y.clamp(0, @map_size) / @grid_size).round
          y_end = ((@offset.y + context.window.height).clamp(0, @map_size) / @grid_size).round

          x_start = (@offset.x.clamp(0, @map_size) / @grid_size).round
          x_end = ((@offset.x + context.window.width).clamp(0, @map_size) / @grid_size).round

          (y_start..y_end).each do |y|
            y *= @grid_size
            (x_start..x_end).each do |x|
              x *= @grid_size

              Gosu.draw_circle(x, y, 4, 9, mouse_near?(x, y, 10.0) ? 0xaa_ffffff : 0xaa_000000, 100)
            end
          end
        end
      end
    end
  end
end
