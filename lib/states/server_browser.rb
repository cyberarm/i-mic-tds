module IMICTDS
  class States
    class ServerBrowser < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        stack(width: 1.0, height: 1.0, padding: 32) do
          background 0xaa_252525

          banner NAME, width: 1.0, text_align: :center
          title "Server Browser", width: 1.0, text_align: :center

          stack(width: 256, fill: true, h_align: :center) do
          end
        end
      end
    end
  end
end
