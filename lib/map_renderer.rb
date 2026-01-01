module IMICTDS
  class MapRenderer
    def self.draw_map(map, context)
      # Map background
      Gosu.draw_rect(0, 0, context.window.width, context.window.height, 0xff_26a269)

      Gosu.translate(-map.offset.x, -map.offset.y) do
        Gosu.scale(map.zoom, map.zoom, context.window.width / 2, context.window.height / 2) do
          # TODO: Map play area
          map.play_area.each(&:draw)

          # TODO: Map obstructions
          map.obstructions.each(&:draw)

          # TODO: Map game elements
          map.entities.each(&:draw)
        end

        return unless map.edit_mode?

        # Map grid
        y_start = (map.offset.y.clamp(0, map.map_size) / map.grid_size).round
        y_end = ((map.offset.y + context.window.height).clamp(0, map.map_size) / map.grid_size).round

        x_start = (map.offset.x.clamp(0, map.map_size) / map.grid_size).round
        x_end = ((map.offset.x + context.window.width).clamp(0, map.map_size) / map.grid_size).round

        (y_start..y_end).each do |y|
          y *= map.grid_size
          (x_start..x_end).each do |x|
            x *= map.grid_size

            Gosu.draw_circle(x, y, 4, 9, context.mouse_near?(x, y, 10.0) ? 0xaa_ffffff : 0xaa_000000, 100)
          end
        end
      end
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
                  polygon.debug_colors[i]
                end

        Gosu.draw_triangle(
          a.x, a.y, color,
          b.x, b.y, color,
          c.x, c.y, color,
          polygon.z
        )
      end

      return if polygon.border_size.zero? || polygon.points_count < 2

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
