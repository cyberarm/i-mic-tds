module IMICTDS
  module ECS
    module Systems
      class Movement < System
        def truple
          [
            Components::Position,
            Components::Velocity
          ]
        end

        def update(entity_store)
        end

        def fixed_update(entity_store)
        end
      end
    end
  end
end
