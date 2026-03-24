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
    end
  end
end
