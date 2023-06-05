module IMICTDS
  module Networking
    module PacketHandlers

      # Handles encoding/decoding of Player Input packets
      class Input < PacketHandler
        TYPE = 0xff

        # Returns a {Packet}
        def encode(connection, data)
        end

        # Returns a hash or array
        def decode(packet)
        end
      end
    end
  end
end
