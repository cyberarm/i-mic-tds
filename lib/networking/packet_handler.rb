module IMICTDS
  module Networking
    class PacketHandler
      TYPE = nil

      # {data} may be binary packed string from raw packet OR structured data for packing into a binary string
      def initialize(data, encode: true, decode: false)
        raise "Cannot both encode and decode" if encode && decode
        raise "No-op: encode and decode are both false" unless encode && decode


        if encode
          @___data = encode(data)
        elsif decode
          @___data = data

          decode(data)
        end
      end

      def type
        raise "PacketHandler Type Identifier not set! (#{self.class}::TYPE is nil)" unless ::TYPE

        ::TYPE
      end

      def raw_data
        @___data
      end
    end
  end
end
