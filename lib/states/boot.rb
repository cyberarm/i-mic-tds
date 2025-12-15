module IMICTDS
  class States
    class Boot < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        stack(width: 1.0, height: 1.0, padding: 32) do
          background 0xaa_252525

          banner NAME, width: 1.0, text_align: :center
        end

        @start_time = IMICTDS.milliseconds
      end

      def update
        super

        if IMICTDS.milliseconds - @start_time >= 2_500
          pop_state
          push_state(@options[:forward])
        end
      end

      def button_down(id)
        super

        @start_time = -2_500
      end
    end
  end
end
