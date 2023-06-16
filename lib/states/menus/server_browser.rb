module IMICTDS
  class States
    class ServerBrowser < Menu
      def menu_setup
        banner NAME, width: 1.0, text_align: :center

        title "Server Browser", width: 1.0, text_align: :center

        stack(width: 1.0, max_width: 900, border_thickness: 2, border_color: 0xaa_252525, fill: true, h_align: :center, scroll: true) do
          background 0xff_785651

          20.times do |i|
            flow(width: 1.0, height: 28, padding: 8) do
              background i.even? ? 0 : 0xaa_454545

              caption "0" * 48, width: 536, text_wrap: :none, margin_right: 8
              caption ["Capture the Flag", "Team Deathmatch", "Detonation", "King of the Hill", "All Modes (CTF)", "All Modes (TDM)", "All Modes (DEMO)", "All Modes (KotH)"].sample, fill: true, margin_left: 8, margin_right: 8, text_wrap: :none
              caption "#{rand(0..16)}/16", margin_left: 8, margin_right: 8, text_wrap: :none
              image get_image("#{ROOT_PATH}/assets/ui_icons/signal3.png"), height: 1.0, color: 0xff_008000, tip: "8888ms"
              button get_image("#{ROOT_PATH}/assets/ui_icons/arrowRight.png"), image_height: 1.0, padding_top: 2, padding_bottom: 2, min_width: nil
            end
          end
        end

        flow(width: 1.0, max_width: 900, height: 40, padding: 4, h_align: :center) do
          button "BACK", height: 1.0 do
            pop_state
          end

          flow(fill: true)

          tagline "YOUR_NICKNAME_HERE", v_align: :center, height: 1.0, padding_top: 8
          button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil

          flow(fill: true)

          button "HOST GAME", height: 1.0 do
            push_state(States::HostGame)
          end
        end
      end
    end
  end
end
