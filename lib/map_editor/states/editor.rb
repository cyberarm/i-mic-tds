module IMICTDS
  module MapEditor
    class States
      class Editor < CyberarmEngine::GuiState
        def setup
          theme(THEME)

          t = Gosu.milliseconds
          @server = IMICTDS::Networking::Server.new(host: "localhost", port: 56789, channels: 8, map: nil, game_mode: :edit)
          @client = IMICTDS::Networking::Client.new(host: "localhost", port: 56789, channels: 8)
          @client.connect(0)

          stack(max_width: 384, width: 1.0, height: 1.0, background: 0xdd_b5835a, border_thickness: 2, border_color: 0xaa_252525) do

            banner "Map Editor", width: 1.0, text_align: :center, margin_top: 32
            flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_left: 32, margin_right: 32, padding: 4) do
              button get_image("#{ROOT_PATH}/assets/ui_icons/exit.png"), image_height: 1.0, min_width: nil, tip: "Save map and close editor" do
                pop_state
              end

              edit_line "MAP_NAME_HERE", fill: true, height: 1.0

              button get_image("#{ROOT_PATH}/assets/ui_icons/save.png"), image_height: 1.0, min_width: nil, tip: "Save map"
              button get_image("#{ROOT_PATH}/assets/ui_icons/right.png"), image_height: 1.0, min_width: nil, tip: "Test map"
            end

            stack(width: 1.0, fill: true, padding: 32, scroll: true) do
              title "Play Space", width: 1.0, text_align: :center, tip: "Closed polygon defining the play area"
              flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32, padding: 4) do
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                flow(fill: true)
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
              end

              title "Obstructions", width: 1.0, text_align: :center, tip: "Closed polygons that obstruct the play space"
              stack(width: 1.0, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32) do
                10.times do |i|
                  flow(width: 1.0, height: 40, padding: 4) do
                    background i.even? ? 0 : 0xaa_252525

                    edit_line "0" * 32, fill: true, height: 1.0
                    button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                    button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
                  end
                end
              end

              title "Game Elements", width: 1.0, text_align: :center, tip: "Flag(s), Bomb(s), King of the Hill(s), and player spawn points"
              stack(width: 1.0, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32) do
                flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color_bottom: 0xaa_252525, margin_bottom: 16, padding: 4) do
                  6.times do
                    button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                  end
                end

                10.times do |i|
                  flow(width: 1.0, height: 40, padding: 4) do
                    background i.even? ? 0 : 0xaa_252525

                    tagline ["Red Flag", "Blue Flag", "Bomb", "Red Spawn", "Blue Spawn"].sample, fill: true
                    button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                    button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
                  end
                end
              end

              title "AI", width: 1.0, text_align: :center, tip: "[Description pending...]"
              stack(width: 1.0, border_thickness: 2, border_color: 0xaa_252525) do
                flow(width: 1.0, height: 40, border_thickness_bottom: 2, border_color_bottom: 0xaa_252525, margin_bottom: 16, padding: 4) do
                  6.times do
                    button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                  end
                end

                10.times do |i|
                  flow(width: 1.0, height: 40, padding: 4) do
                    background i.even? ? 0 : 0xaa_252525

                    tagline ["Path Hint", "Meet Up", "Generate Pathfind"].sample, fill: true
                    button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                    button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
                  end
                end
              end
            end
          end

          @map = Map.new
          @map.edit_mode = true

          @polygon = Polygon.new(
            [
              CyberarmEngine::Vector.new(window.width / 2 - 100, window.height / 2 - 100),
              CyberarmEngine::Vector.new(window.width / 2, window.height / 2 - 100),
              CyberarmEngine::Vector.new(window.width / 2, window.height / 2 - 50),
              CyberarmEngine::Vector.new(window.width / 2 + 100, window.height / 2 - 50),
              CyberarmEngine::Vector.new(window.width / 2 + 100, window.height / 2 + 100),
              CyberarmEngine::Vector.new(window.width / 2 - 100, window.height / 2 - 100)
            ],
            121,
            Gosu::Color.new(0xaa_aaaaaa),
            Gosu::Color::GREEN,
            4
          )
        end

        def draw
          @map.draw
          @polygon.draw

          Gosu.flush

          super
        end

        def update
          @server.think
          @client.think

          @map.update

          super
        end

        def button_down(id)
          @map.button_down(id)

          super
        end

        def button_up(id)
          @map.button_up(id)

          super
        end
      end
    end
  end
end
