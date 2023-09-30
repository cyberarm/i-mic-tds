module IMICTDS
  class Window < CyberarmEngine::Window
    def setup
      self.caption = format("%s (v%s) [%s]", NAME, VERSION, VERSION_NAME)

      self.update_interval = 0.001 / 60 # Only limited by v-sync
      self.show_stats_plotter = false
      self.show_cursor = true

      if DEVELOPMENT_MODE
        push_state(States::MainMenu)
      else
        push_state(CyberarmEngine::IntroState, forward: States::Boot, forward_options: { forward: States::MainMenu })
      end
    end

    def needs_redraw?
      states.any?(&:needs_repaint?)
    end
  end
end
