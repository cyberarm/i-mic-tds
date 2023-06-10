module IMICTDS
  module ECS
    module Components
      class Team < Component
        attr_accessor :team

        def initialize(team:)
          raise "Team must be an Integer, got #{team.class}" unless team.is_a?(Integer)

          @team = team
        end
      end
    end
  end
end
