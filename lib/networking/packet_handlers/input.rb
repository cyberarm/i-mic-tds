module IMICTDS
  module Networking
    class PacketHandler
      # Handles encoding/decoding of Player Input packets
      class Input < PacketHandler
        TYPE = 0x00

        # Returns a binary packed string
        def encode(data); end

        # Returns a hash or array
        def decode(data); end
      end
    end
  end
end
