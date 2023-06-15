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
            tagline "Name", width: 128
            edit_line "YOUR_NICKNAME_HERE's Game", fill: true
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Password", width: 128
            edit_line "YOUR_NICKNAME_HERE's Game", fill: true, type: :password
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Game Mode", width: 128
            list_box items: [ "Team Deathmatch", "Capture the Flag", "Demolition", "All" ], fill: true
          end

          flow(width: 1.0, height: 40, margin_top: 4) do
            tagline "Max Players", width: 128
            list_box items: [2, 4, 8, 12, 16].map(&:to_s), choose: "8", fill: true
          end

          tagline "Bots"
          flow(width: 1.0, height: 36, margin_top: 4, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
            flow(fill: true, height: 32, margin_top: 4) do
              caption "Difficulty"
              list_box items: %w[Easy Hard Brutal], fill: true, height: 1.0
            end

            flow(fill: true, height: 32, margin_top: 4, margin_left: 16) do
              toggle_button checked: true, height: 1.0
              caption "Pad Players with Bots", fill: true
            end

            flow(fill: true, height: 32, margin_top: 4, margin_left: 16) do
              toggle_button checked: true, height: 1.0, tip: "One team is only bots"
              caption "Co-op", fill: true
            end
          end

          tagline "Spectators"
          flow(width: 1.0, height: 32, margin_top: 4, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525) do
            toggle_button checked: true, height: 1.0
            caption "Allow spectators"
          end

          tagline "Maps"
          flow(width: 1.0, fill: true, margin_left: 32, padding: 4, border_thickness: 2, border_color: 0xaa_252525, scroll: true) do
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
          button "Back", height: 1.0 do
            pop_state
          end

          flow(fill: true)

          button "Start Game", height: 1.0 do
            # Start server
            # Connect client
            # Join game
          end
        end
      end
    end
  end
end
