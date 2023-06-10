module IMICTDS
  module ECS
    class Entity
      attr_reader :components

      def initialize
        @components = []
      end

      def add_component(component)
        @components << component
      end

      def component(component)
        @components.find { |c| c == component }
      end

      def remove_component(component)
        @components.delete_if { |c| c == component }
      end
    end
  end
end
