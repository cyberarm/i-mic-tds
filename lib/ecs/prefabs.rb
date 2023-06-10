module IMICTDS
  module ECS
    class Prefabs
      def self.player(entity_store, position:, team:)
        entity_store.create_entity(
          Position.new(position: position),
          Team.new(team: team)
        )
      end
    end
  end
end
