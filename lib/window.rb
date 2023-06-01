module IMICTDS
  class Window < CyberarmEngine::Window
    def setup
      self.caption = format("%s (v%s)", NAME, VERSION)

      self.update_interval = 60 / 1.0 # Only limited by v-sync
      self.show_stats_plotter = false
      self.show_cursor = true

      push_state(States::Boot, forward: States::MainMenu)
    end

    def needs_redraw?
      states.any?(&:needs_repaint?)
    end
  end
end
