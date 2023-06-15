module IMICTDS
  class States
    class Menu < CyberarmEngine::GuiState
      def setup
        theme(THEME)

        @container = stack(width: 1.0, height: 1.0, padding: 32, background: 0xdd_b5835a, background_image: "#{ROOT_PATH}/assets/ui/background.png") do
          menu_setup
        end
      end
    end
  end
end
