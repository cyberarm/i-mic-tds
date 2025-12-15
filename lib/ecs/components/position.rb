module IMICTDS
  module ECS
    class Component
      class Position < Component
        attr_reader :position

        def initialize(position:)
          raise "Position must be a CyberarmEngine::Vector, got #{position.class}" unless position.is_a?(CyberarmEngine::Vector)

          @position = position
        end
      end
    end
  end
end
