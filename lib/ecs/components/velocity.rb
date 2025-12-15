module IMICTDS
  module ECS
    class Component
      class Velocity < Component
        attr_reader :velocity

        def initialize(velocity:)
          raise "Velocity must be a CyberarmEngine::Vector, got #{velocity.class}" unless velocity.is_a?(CyberarmEngine::Vector)

          @velocity = velocity
        end
      end
    end
  end
end
