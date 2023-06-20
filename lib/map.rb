module IMICTDS
  class Map
    include CyberarmEngine::Common

    attr_reader :play_area, :obstructions, :entities, :grid_size
    attr_accessor :edit_mode

    def initialize(map_file: nil)
      @palette = :default
      @play_area = []
      @obstructions = []
      @entities = []
      @grid_size = 96


      @offset = CyberarmEngine::Vector.new(0, 0)
      @zoom = 1.0
      @min_zoom = 0.25
      @max_zoom = 2.5

      @edit_mode = false
    end

    def draw
      # Map background
      Gosu.draw_rect(0, 0, window.width, window.height, 0xff_252525)

      # TODO: Map play area
      # TODO: Map obstructions
      # TODO: Map game elements

      # Map grid
      (window.height / 96.0).ceil.times do |y|
        (window.width / 96.0).ceil.times do |x|
          Gosu.draw_circle(x * 96, y * 96, 4, 9, 0xff_343485, 100)
        end
      end
    end

    def update
    end

    def button_down(id)
    end

    def button_up(id)
    end
  end
end
