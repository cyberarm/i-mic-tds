module IMICTDS
  module MapEditor
    class Tool
      def self.name
        raise NotImplementedError, "Tool has no name :("
      end

      def self.draw(map, context)
      end

      def self.update(map, context)
      end

      def self.button_down(id, map, context)
      end

      def self.button_up(id, map, context)
      end

      def self.mouse_point(map, context)
        map.grid_point(
          map.transform_point(
            CyberarmEngine::Vector.new(
              context.window.mouse_x,
              context.window.mouse_y
            )
          )
        )
      end
    end
  end
end
