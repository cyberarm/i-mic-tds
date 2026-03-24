module IMICTDS
  module MapEditor
    class Tool
      # Create and edit shapes on the map
      class ShapeTool < Tool
        def self.name
          "Shape"
        end

        def self.button_down(id, map, context)
          case id
          when Gosu::MS_LEFT
            context.active_item.polygon.points << map.transform_point(
              CyberarmEngine::Vector.new(
                context.window.mouse_x, context.window.mouse_y
              )
            )
          end
        end
      end
    end
  end
end
