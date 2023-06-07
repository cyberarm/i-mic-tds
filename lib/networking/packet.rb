module IMICTDS
  module Networking
    class Packet
      PROTOCOL_VERSION = 0
      PROTOCOL_IDENTIFIER = "ITDS".freeze

      MAGICAL_PREFIX = [PROTOCOL_IDENTIFIER.bytes, PROTOCOL_VERSION].flatten.pack("C4n")

      def self.crc32(data)
        Digest::CRC32.new("#{MAGICAL_PREFIX}#{data}")
      end

      def self.verify_crc32(crc, data)
        crc == crc32(data)
      end
    end
  end
end
