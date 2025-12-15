module IMICTDS
  class States
    class Connecting < CyberarmEngine::GuiState
      def setup
        @remote_host = @options[:host]
        @remote_port = @options[:port]

        @forward = @options[:forward]
        @forward_options = @options[:forward_options] || {}

        theme(THEME)

        stack(width: 1.0, height: 1.0, padding: 32) do
          background 0xaa_252525

          banner "Connecting to #{@remote_host}:#{@remote_port}...", width: 1.0, text_align: :center
          title "Please wait...", width: 1.0, text_align: :center
        end

        window.connect_to(host: @remote_host, port: @remote_port)
      end

      def update
        super

        return unless window.connection&.connected?

        pop_state
        push_state(@forward, **@forward_options)
      end

      def button_down(id)
        super
      end
    end
  end
end
