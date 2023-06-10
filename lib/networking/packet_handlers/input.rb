module IMICTDS
  module Networking
    module PacketHandlers
      # Handles encoding/decoding of Player Input packets
      class Input < PacketHandler
        TYPE = 0xff

        # Returns a binary packed string
        def encode(data)
        end

        # Returns a hash or array
        def decode(data)
        end
      end
    end
  end
end
