module IMICTDS
  module Networking
    class PacketHandler
      # Handles encoding/decoding of Server game state (snapshot)
      class Snapshot < PacketHandler
        TYPE = 0x01

        # Returns a binary packed string
        def encode(data); end

        # Returns a hash or array
        def decode(data); end
      end
    end
  end
end
