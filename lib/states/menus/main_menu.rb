module IMICTDS
  class States
    class MainMenu < Menu
      def menu_setup
        banner NAME, width: 1.0, text_align: :center
        title "Main Menu", width: 1.0, text_align: :center

        stack(width: 256, fill: true, h_align: :center) do
          button "PLAY", width: 1.0 do
            push_state(States::ServerBrowser)
          end
          button "PROFILE", width: 1.0
          button "SETTINGS", width: 1.0
          button "EXIT", margin_top: 32, width: 1.0 do
            close
          end
        end
      end
    end
  end
end
