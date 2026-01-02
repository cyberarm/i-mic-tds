module IMICTDS
  class Map
    SCHEMA = 0

    attr_reader :play_space, :shapes, :entities, :prefabs, :grid_size, :map_size, :zoom_step
    attr_accessor :drag_start, :edit_mode, :offset, :zoom, :min_zoom, :max_zoom

    def initialize
      @palette = :default

      # map metadata
      @schema = SCHEMA
      @name = ""
      @version = "0.0.0"
      @uuid = ""
      @authors = []
      @grid_size = 64
      @created_at = Time.now.utc.iso8601
      @updated_at = Time.now.utc.iso8601

      # map data
      @play_space = nil # A special shape
      @shapes = []
      @prefabs = []
      @entities = []

      @map_size = 1024 * 8

      # stuff that belongs in the renderer, probably...
      @offset = CyberarmEngine::Vector.new
      @zoom = 1.0
      @min_zoom = 0.25
      @max_zoom = 2.5
      @zoom_step = 0.25

      # stuff that belongs in the Editor, probably...
      @edit_mode = false
      @drag_start = nil
    end

    def load(map_file:)
      hash = JSON.parse(map_file, symbolize_names: true)

      # metadata
      @schema = hash.dig(:metadata, :schema)
      @name = hash.dig(:metadata, :name)
      @version = hash.dig(:metadata, :version)
      @uuid = hash.dig(:metadata, :uuid)
      @authors = hash.dig(:metadata, :authors)
      @grid_size = hash.dig(:metadata, :grid_size)
      @created_at = hash.dig(:metadata, :created_at)
      @updated_at = hash.dig(:metadata, :updated_at)

      # data
      @play_space = Shape.from_hash(hash.dig(:play_space))
      @shapes = hash.dig(:shapes).map { |o| Shape.from_hash(o) }
      @prefabs = hash.dig(:prefabs).map { |o| Shape.from_hash(o) }
      @entities = hash.dig(:entities).map { |o| Shape.from_hash(o) }
    end

    def save(map_file:)
      hash = {
        metadata: {
          schema: @schema,
          name: @name,
          version: @version,
          uuid: @uuid,
          authors: [ "Human" ],
          grid_size: @grid_size,
          created_at: Time.now.utc.iso8601,
          updated_at: Time.now.utc.iso8601
        },
        play_space: @play_space,
        shapes: @shapes,
        prefabs: @prefabs,
        entities: @entities
      }

      File.write(map_file, JSON.pretty_generate(hash))
    end

    def edit_mode?
      @edit_mode
    end
  end
end
