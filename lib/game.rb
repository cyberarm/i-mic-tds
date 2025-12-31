module IMICTDS
  class Game
    SIMULATION_INTERVAL = 1.0 / 128 # 128 "ticks" per second
    DEATH_SPIRAL_MAX_FRAME_TIME = 0.25 # seconds

    attr_reader :entity_store, :map, :game_mode, :game_master, :time

    def initialize(map:, game_mode:, game_master:)
      @entity_store = ECS::EntityStore.new
      @map = map
      @game_mode = game_mode
      @game_master = game_master

      # NOTE: This is the ONLY source of time for the WHOLE game,
      #       Using IMICTDS.milliseconds directly WILL break replays and otherwise lead to sadness.
      @time = 0.0
      @accumulator = 0.0
      @alpha = 0.0

      @current_time = IMICTDS.milliseconds
      pp @current_time
    end

    # Fix Your Timestep!: https://gafferongames.com/post/fix_your_timestep/
    def update(simulation_callback: nil)
      # Handle player inputs
      # Simulate game using fixed timestep

      new_time = IMICTDS.milliseconds
      frame_time = (new_time - @current_time) / 1000.0
      frame_time = DEATH_SPIRAL_MAX_FRAME_TIME if frame_time > DEATH_SPIRAL_MAX_FRAME_TIME
      @current_time = new_time

      @accumulator += frame_time

      while @accumulator >= SIMULATION_INTERVAL
        simulate(SIMULATION_INTERVAL)
        # callback to call AFTER the simulation has been simulated
        simulation_callback&.call

        @time += SIMULATION_INTERVAL
        @accumulator -= SIMULATION_INTERVAL
      end

      @alpha = @accumulator / SIMULATION_INTERVAL
    end

    # Run ta sim-u-late-ion
    # NOTE: {dt} MUST be a static value
    def simulate(dt); end
  end
end
