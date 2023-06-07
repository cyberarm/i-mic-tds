module IMICTDS
  module Networking
    class Connection
      MTU = 1200

      attr_reader :host, :port, :send_queue, :read_queue

      def initialize(host:, port:, i_am_server: false)
        @host = host
        @port = port
        @i_am_server = i_am_server

        @connected = false

        @send_queue = []
        @read_queue = []
      end

      def server?
        @i_am_server
      end

      def client?
        !server?
      end

      def connected?
        client? && @connected
      end

      def connect
        raise "Server cannot connect to itself!" if server?

        @socket = UDPSocket.new(@host, @port)
        @socket.connect

        write(PacketHandlers::Connect.new(nil))
      end

      def write(data)
      end

      def read
        @socket.recv_nonblock(MTU)
      rescue IO::WaitReadable
        nil
      end

      def ingest_packet(pkt)
        data, = pkt

        # Require CRC32 and packet type
        return if data.length < 5
        # Discard if CRC32 doesn't include Packet::MAGICAL_PREFIX or is otherwise invalid
        return unless Packet.verify_crc32(data[0..3].unpack("C*"), data[4..])
      end

      def update
        while (pkt = read)
          ingest_packet(pkt)
        end

        # FIXME: Don't forget packets until they've been acknowledged, if needed.
        while (data = @send_queue.shift)
          @socket.send(data)
        end
      end
    end
  end
end
