module IMICTDS
  class Map
    include CyberarmEngine::Common

    attr_reader :play_area, :obstructions, :entities, :grid_size
    attr_accessor :edit_mode, :offset, :zoom, :min_zoom, :max_zoom

    def initialize
      @palette = :default
      @play_area = []
      @obstructions = []
      @entities = []
      @grid_size = 64
      @map_size = 1024 * 8

      @offset = CyberarmEngine::Vector.new(@map_size / 2 - window.width / 2, @map_size / 2 - window.height / 2)
      @zoom = 1.0
      @min_zoom = 0.25
      @max_zoom = 2.5
      @zoom_step = 0.25

      @edit_mode = false
    end

    def load(map_file:)
    end

    def save(map_file:)
    end

    def edit_mode?
      @edit_mode
    end

    def draw
      # Map background
      Gosu.draw_rect(0, 0, window.width, window.height, 0xff_26a269)

      Gosu.translate(-@offset.x, -@offset.y) do
        Gosu.scale(@zoom, @zoom, window.width / 2, window.height / 2) do
          # TODO: Map play area
          @play_area.each(&:draw)

          # TODO: Map obstructions
          @obstructions.each(&:draw)

          # TODO: Map game elements
          @entities.each(&:draw)
        end

        return unless edit_mode?

        # Map grid
        y_start = ((@offset.y).clamp(0, @map_size) / @grid_size).round
        y_end = ((@offset.y + window.height).clamp(0, @map_size) / @grid_size).round

        x_start = ((@offset.x).clamp(0, @map_size) / @grid_size).round
        x_end = ((@offset.x + window.width).clamp(0, @map_size) / @grid_size).round

        (y_start..y_end).each do |y|
          y = y * @grid_size
          (x_start..x_end).each do |x|
            x = x * @grid_size

            Gosu.draw_circle(x, y, 4, 9, mouse_near?(x, y, 10.0) ? 0xaa_ffffff : 0xaa_000000, 100)
          end
        end
      end
    end

    def update

      return unless edit_mode?

      if @drag_start
        delta = @drag_start - CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y)

        @offset += delta

        @drag_start -= delta
      end
    end

    def button_down(id)
      return unless edit_mode?

      case id
      when Gosu::MS_WHEEL_UP
        @zoom += @zoom_step
        @zoom = @max_zoom if @zoom > @max_zoom
      when Gosu::MS_WHEEL_DOWN
        @zoom -= @zoom_step
        @zoom = @min_zoom if @zoom < @min_zoom
      when Gosu::MS_MIDDLE
        @drag_start = CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y)
      end
    end

    def button_up(id)
      return unless edit_mode?

      case id
      when Gosu::MS_MIDDLE
        @drag_start = nil
      end
    end

    def mouse_near?(x, y, dist)
      Gosu.distance(window.mouse_x + @offset.x * @zoom, window.mouse_y + @offset.y * @zoom, x, y) <= dist
    end
  end
end
