module IMICTDS
  class States
    class ServerBrowser < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        stack(width: 1.0, height: 1.0, padding: 32) do
          background 0xaa_252525

          banner NAME, width: 1.0, text_align: :center
          title "Server Browser", width: 1.0, text_align: :center

          stack(width: 1.0, max_width: 900, border_thickness: 4, border_color: 0xff_ef51ad, fill: true, h_align: :center, scroll: true) do
            background 0xff_353535

            20.times do |i|
              flow(width: 1.0, height: 28, padding: 8) do
                background i.even? ? 0xff_353535 : 0xff_454545

                caption "0" * 48, width: 536, text_wrap: :none
                caption ["Capture the Flag", "Team Deathmatch", "Detonation"].sample, fill: true
                caption "00/00"
                caption "8888ms"
                button "→", height: 1.0, padding_top: 2, padding_bottom: 2
              end
            end
          end
        end
      end
    end
  end
end
