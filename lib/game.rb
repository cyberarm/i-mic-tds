module IMICTDS
  class Game
    SIMULATION_INTERVAL = 1.0 / 128 # 120 "ticks" per second
    DEATH_SPIRAL_MAX_FRAME_TIME = 0.25 # seconds

    def initialize(map:, game_mode:)
      @map = map
      @game_mode = game_mode

      @time = 0.0
      @accumulator = 0.0
      @alpha = 0.0
    end

    # Fix Your Timestep!: https://gafferongames.com/post/fix_your_timestep/
    def update(inputs)
      # Handle player inputs
      # Simulate game using fixed timestep

      frame_time = CyberarmEngine::Window.dt
      frame_time = DEATH_SPIRAL_MAX_FRAME_TIME if frame_time > DEATH_SPIRAL_MAX_FRAME_TIME

      @accumulator += frame_time

      while @accumulator >= SIMULATION_INTERVAL
        simulate(SIMULATION_INTERVAL)

        @time += SIMULATION_INTERVAL
        @accumulator -= SIMULATION_INTERVAL
      end

      @alpha = @accumulator / SIMULATION_INTERVAL
    end

    # NOTE: {dt} MUST be a static value
    def simulate(dt)

    end
  end
end
