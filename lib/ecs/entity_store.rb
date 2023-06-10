module IMICTDS
  module ECS
    class EntityStore
      def initialize
        @entities = []
      end

      def add_entity(entity)
        @entities << entity
      end

      def find_entity(id)
        @entities.find { |e| e.id == id }
      end

      def entity_with(components)
      end

      def entities_with(components)
      end

      def remove_entity(entity)
        @entities.delete_if { |e| e == entity }
      end

      def remove_entities(list)
      end

      def remove_all_entities
        @entities.clear
      end
    end
  end
end
