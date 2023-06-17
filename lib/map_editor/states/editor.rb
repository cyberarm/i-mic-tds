module IMICTDS
  module MapEditor
    class States
      class Editor < CyberarmEngine::GuiState
        def setup
          theme(THEME)

          flow(width: 1.0, height: 1.0) do
            stack(max_width: 384, width: 1.0, height: 1.0, padding: 32, background: 0xdd_b5835a, border_thickness: 2, border_color: 0xaa_252525, scroll: true) do

              banner "Map Editor", width: 1.0, text_align: :center
              flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32, padding: 4) do
                title "MAP_NAME_HERE", fill: true, word_wrap: :none

                button get_image("#{ROOT_PATH}/assets/ui_icons/save.png"), image_height: 1.0, min_width: nil
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
              end

              title "Play Space", width: 1.0, text_align: :center, tip: "Closed polygon defining the play area"
              flow(width: 1.0, height: 40, border_thickness: 2, border_color: 0xaa_252525, margin_bottom: 32, padding: 4) do
                button get_image("#{ROOT_PATH}/assets/ui_icons/wrench.png"), image_height: 1.0, min_width: nil
                flow(fill: true)
                button get_image("#{ROOT_PATH}/assets/ui_icons/trashCan.png"), image_height: 1.0, min_width: nil
              end

              title "Obstructions", width: 1.0, text_align: :center, tip: "Closed polygon that obstruct the play space"
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

            flow(fill: true)
          end
        end

        def draw
          Gosu.draw_rect(0, 0, window.width, window.height, 0xff_252525)

          super
        end
      end
    end
  end
end
