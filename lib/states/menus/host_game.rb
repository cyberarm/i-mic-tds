module IMICTDS
  class States
    class HostGame < Menu
      def menu_setup
        banner NAME, width: 1.0, text_align: :center

        title "Host Game", width: 1.0, text_align: :center

        # Game Name
        # Game Mode
        # Map rotation
        # Max players

        stack(width: 1.0, max_width: 900, fill: true, padding: 4, h_align: :center, scroll: true, border_thickness: 2, border_color: 0xaa_252525) do
          background 0xff_785651

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Name", width: 156
            edit_line "YOUR_NICKNAME_HERE's Game", fill: true
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Password", width: 156
            edit_line "", fill: true, type: :password
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Game Mode", width: 156
            list_box items: [ "Team Deathmatch", "Capture the Flag", "Demolition", "King of the Hill", "All Modes" ], choose: "All Modes", fill: true
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Max Players", width: 156
            list_box items: [2, 4, 8, 12, 16].map(&:to_s), choose: "8", fill: true
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Network", width: 156
            list_box items: ["Hosted", "LAN", "Internet"], choose: "Hosted", fill: true
          end

          tagline "Bots", margin_top: 16
          flow(width: 1.0, height: 36, margin_top: 4, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
            flow(fill: true, height: 32, margin_top: 4, margin_left: 16) do
              toggle_button checked: true, height: 1.0
              caption "Fill empty slots with bots", fill: true
            end

            flow(width: 128, height: 32, margin_top: 4, margin_left: 16) do
              toggle_button checked: true, height: 1.0, tip: "All human players are on one team and only bots on the other"
              caption "Co-op", fill: true
            end

            flow(fill: true, height: 32, margin_top: 4) do
              caption "Difficulty"
              list_box items: %w[Easy Hard Brutal], fill: true, height: 1.0
            end
          end

          tagline "Spectators", margin_top: 16
          flow(width: 1.0, height: 32, margin_top: 4, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
            toggle_button checked: true, height: 1.0
            caption "Allow spectators"
          end

          tagline "Maps", margin_top: 16
          flow(width: 1.0, fill: true, min_height: 128, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525, scroll: true) do
            ["Grassland", "Forest", "Metro"].each_with_index do |map, i|
              flow(width: 1.0, height: 32) do
                background i.even? ? 0 : 0xaa_252525

                toggle_button checked: true, height: 1.0
                caption map
              end
            end
          end
        end


        flow(width: 1.0, max_width: 900, height: 40, padding: 4, h_align: :center) do
          button "BACK", height: 1.0 do
            pop_state
          end

          flow(fill: true)

          button "START GAME", height: 1.0 do
            # Start server
            # Connect client
            # Join game
          end
        end
      end
    end
  end
end
