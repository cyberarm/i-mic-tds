module IMICTDS
  module Networking
    class Connection < ENet::Connection
      def think
        # TODO: "drain" queued packets instead of only taking one
        update(0)
      end

      def on_connection
        puts "Connected to #{@client.address.host}:#{@client.address.port}"
      end

      def on_packet_received(data, channel)
        pp [data, channel]

        # Require CRC32 and packet type
        return if data.length < 5

        # Discard if CRC32 doesn't include Packet::MAGICAL_PREFIX or is otherwise invalid
        return unless Packet.verify_crc32(data[0..3].unpack("C*"), data[4..])

        # TODO: Do stuff
      end

      def on_disconnection
      end
    end
  end
end
