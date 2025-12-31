module IMICTDS
  module Networking
    class Connection < ENet::Connection
      def think
        # Service enet so we send and receive them delicious ~~cookies~~packets
        while update(0) > 0
        end
      end

      def on_connection
        puts "Connected to #{@client.address.host}:#{@client.address.port}"
      end

      def on_packet_received(data, channel)
        # pp [data, channel]
        send_packet(data, channel: channel, reliable: false)

        # Require CRC32 and packet type
        return if data.length < 5

        # Discard if CRC32 doesn't include Packet::MAGICAL_PREFIX or is otherwise invalid
        # FIXME: If server continually sends invalid packets then disconnect with version mismatch!
        nil unless Packet.verify_crc32(data[0..3].unpack("C*"), data[4..])

        # TODO: Do stuff
      end

      def on_disconnection
        # TODO: Alarm, we've been disconnected!
      end
    end
  end
end
