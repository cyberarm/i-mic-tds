module IMICTDS
  module ECS
    class Component
      class Position < Component
        attr_reader :position

        def initialize(position:)
          unless position.is_a?(CyberarmEngine::Vector)
            raise "Position must be a CyberarmEngine::Vector, got #{position.class}"
          end

          @position = position
        end
      end
    end
  end
end
