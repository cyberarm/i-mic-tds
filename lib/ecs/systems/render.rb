module IMICTDS
  module ECS
    module Systems
      class Render < System
        def truple
          [
            Components::Position,
            Components::Render
          ]
        end

        def draw(entity_store)
        end
      end
    end
  end
end
