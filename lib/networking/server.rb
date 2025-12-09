module IMICTDS
  module Networking
    class Server < ENet::Server
      def initialize(host:, port:, max_clients: DEFAULT_MAX_CLIENTS, channels: DEFAULT_CHANNEL_COUNT, download_bandwidth: 0, upload_bandwidth: 0, config: {})
        super(
          host: host, port: port, max_clients: max_clients, channels: channels,
          download_bandwidth: download_bandwidth, upload_bandwidth: upload_bandwidth
        )

        @config = config

        # @map = map # Map loaded from file, or blank editor map
        # @game_mode = game_mode # :tdm, :ctf, :demo, :koth, :edit
        # @game_master = game_master # nickname of "game master/host" or nil if managed server
      end

      def think
        # TODO: "drain" queued packets instead of only taking one
        update(0)

        # TODO: Advertise server on LAN via multicast
        # REF: https://github.com/jpignata/blog/blob/master/articles/multicast-in-ruby.md

        simulate
      end

      # Run ta sim-u-late-ion
      def simulate
        return unless Gosu.milliseconds % 1000

        t = Gosu.milliseconds
        broadcast_packet("#{Packet.crc32(t.to_s)}#{t}", reliable: true, channel: 0)
      end

      def on_connection(client)
        puts "Client Connected: #{client.id}"
        send_packet(client, "#{Packet.crc32("WELCOME")}WELCOME", reliable: true, channel: 0)
      end

      def on_packet_received(client, data, channel)
        # Require CRC32 and packet type
        return if data.length < 5

        # Discard if CRC32 doesn't include Packet::MAGICAL_PREFIX or is otherwise invalid
        return unless Packet.verify_crc32(data[0..3].unpack("C*"), data[4..])

        # TODO: Hand packet to packet handler
      end

      def on_disconnection(client)
        puts "Client Disconnected."
      end
    end
  end
end
