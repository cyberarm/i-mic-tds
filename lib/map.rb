module IMICTDS
  class Map
    attr_reader :play_area, :obstructions, :entities, :grid_size, :map_size, :zoom_step
    attr_accessor :drag_start, :edit_mode, :offset, :zoom, :min_zoom, :max_zoom

    def initialize
      @palette = :default
      @play_area = []
      @obstructions = []
      @entities = []
      @grid_size = 64
      @map_size = 1024 * 8

      @offset = CyberarmEngine::Vector.new
      @zoom = 1.0
      @min_zoom = 0.25
      @max_zoom = 2.5
      @zoom_step = 0.25

      @edit_mode = false
      @drag_start = nil
    end

    def load(map_file:); end

    def save(map_file:); end

    def edit_mode?
      @edit_mode
    end
  end
end
