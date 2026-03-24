module IMICTDS
  class MapRenderer
    GRID_DOT = Gosu.render(8, 8, false) do
      Gosu.draw_circle(4, 4, 4, 18, 0xff_ffffff, 100)
    end

    def self.draw_map(map, context)
      # Map background
      Gosu.draw_rect(0, 0, context.window.width, context.window.height, 0xff_26a269)

      Gosu.translate(-map.offset.x, -map.offset.y) do
        Gosu.scale(map.zoom, map.zoom, context.window.width / 2, context.window.height / 2) do
          # TODO: Map play space
          draw_shape(map.play_space, context)

          map.shapes.each { |s| draw_shape(s, context) }

          # TODO: Map game elements
          map.entities.each(&:draw)
        end

        # NOTE: grid points are not, yet, effected by scale.
        draw_grid(map, context) if map.edit_mode?
      end
    end

    def self.draw_grid(map, context)
      # Map grid
      y_start = (map.offset.y.clamp(0, map.map_size) / map.grid_size).round
      y_end = ((map.offset.y + context.window.height).clamp(0, map.map_size) / map.grid_size).round

      x_start = (map.offset.x.clamp(0, map.map_size) / map.grid_size).round
      x_end = ((map.offset.x + context.window.width).clamp(0, map.map_size) / map.grid_size).round

      grid_line_color = 0x02_000000
      diagonal_grid_line_color = 0x22_000000
      # top left -> bottom right
      Gosu.draw_line(0, 0, diagonal_grid_line_color, map.map_size, map.map_size, diagonal_grid_line_color, 100)
      # top right -> bottom left
      Gosu.draw_line(map.map_size, 0, diagonal_grid_line_color, 0, map.map_size, diagonal_grid_line_color, 100)

      (y_start..y_end).each do |y|
        grid_y = y * map.grid_size

        (x_start..x_end).each do |x|
          grid_x = x * map.grid_size
          color = (x + y).even? ? 0x44_000000 : 0xaa_252525

          # top -> down
          Gosu.draw_line(grid_x, y_start, grid_line_color, grid_x, y_end * map.grid_size, grid_line_color, 100)
          # left -> right
          Gosu.draw_line(x_start, grid_y, grid_line_color, x_end * map.grid_size, grid_y, grid_line_color, 100)

          GRID_DOT.draw_rot(grid_x, grid_y, 100, 0, 0.5, 0.5, 1, 1, 0xff_ffffff) if context.mouse_near?(grid_x, grid_y, 10.0)
        end
      end

      GRID_DOT.draw_rot(map.map_size / 2, map.map_size / 2, 100, 0, 0.5, 0.5, 1, 1, context.mouse_near?(map.map_size / 2, map.map_size / 2, 10.0) ? 0xaa_ffffff : 0xaa_ff8800)
    end

    def self.draw_shape(shape, context)
      draw_polygon(shape.polygon, context)
    end

    def self.draw_polygon(polygon, context)
      polygon.triangulated = false if polygon.points.size != polygon.points_count

      polygon.triangulate unless polygon.triangulated?

      polygon.triangles.each_with_index do |t, i|
        a = t[0]
        b = t[1]
        c = t[2]

        color = if polygon.point_inside_triangle?(CyberarmEngine::Vector.new(context.window.mouse_x, context.window.mouse_y),
                                                  t)
                  polygon.color
                else
                  Polygon::DEBUG_COLORS[i]
                end

        Gosu.draw_triangle(
          a.x, a.y, color,
          b.x, b.y, color,
          c.x, c.y, color,
          polygon.z
        )
      end

      return if polygon.border_thickness.zero? || polygon.points_count < 2

      # TODO: Draw polygon border (using rects so that it can have thickness)
      anchor_point = polygon.points.first
      polygon.points[1...].each do |point|
        Gosu.draw_line(
          anchor_point.x, anchor_point.y, polygon.border_color,
          point.x, point.y, polygon.border_color,
          polygon.z
        )

        anchor_point = point
      end
    end
  end
end
