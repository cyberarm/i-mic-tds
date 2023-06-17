module IMICTDS
  module MapEditor
    class States
      class MainMenu < IMICTDS::States::Menu
        def menu_setup
          banner NAME, width: 1.0, text_align: :center
          title "Map Editor", width: 1.0, text_align: :center

          stack(width: 256, fill: true, h_align: :center) do
            button "CREATE", width: 1.0 do
              push_state(States::Editor)
            end
            button "EDIT", width: 1.0 do
              push_state(States::MapList)
            end

            button "BACK", margin_top: 32, width: 1.0 do
              pop_state
            end
          end
        end
      end
    end
  end
end
