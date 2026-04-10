module IMICTDS
  module MapEditor
    class Tool
      # Create and edit shapes on the map
      class ShapeTool < Tool
        def self.name
          "Shape"
        end

        def self.draw(map, context)
          v = mouse_point(map, context)

          pt = context.active_item.polygon.points.last
          Gosu.draw_line(pt.x, pt.y, Gosu::Color::BLACK, v.x, v.y, Gosu::Color::BLACK, 100) if pt

          dot_color = can_place_point?(v, context) ? 0xff_ffffff : 0xff_aa2200
          IMICTDS::MapRenderer::GRID_DOT.draw_rot(v.x, v.y, 100, 0, 0.5, 0.5, 1 / map.zoom, 1 / map.zoom, dot_color)
        end

        def self.button_down(id, map, context)
          v = mouse_point(map, context)

          case id
          when Gosu::MS_LEFT
            context.active_item.polygon.points << v if can_place_point?(v, context)
          when Gosu::MS_RIGHT
            context.active_item.polygon.points.delete_if { |pt| v == pt && !can_place_point?(v, context) }
          end
        end

        def self.can_place_point?(point, context)
          !context.active_item.polygon.points.any? { |pt| pt == point }
        end
      end
    end
  end
end
