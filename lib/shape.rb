module IMICTDS
  class Shape
    TYPE_BACKGROUND = 0
    TYPE_GROUND = 1
    TYPE_OVERLAY = 2

    attr_accessor :id, :name, :type
    attr_reader :polygon, :texture
    attr_writer :collidable

    def initialize
      @id = 0
      @name = ""
      @type = TYPE_BACKGROUND
      @colliable = false
      @texture = ""
      @polygon = Polygon.new(points: [], z: @type)
    end

    def collidable?
      @collidable
    end

    def texture=(image_path)
      @texture = image_path
      # @polygon.image = image_path
    end

    def point_inside?(vector)
      @polygon.point_inside?(vector)
    end

    def point_inside_triangle?(point, triangle)
      @polygon.point_inside_triangle?(point, triangle)
    end

    def draw
      @polygon.draw
    end

    def load(hash)
      @polygon.points.clear

      @id = hash[:id]
      @name = hash[:name]
      @type = hash[:type]
      @colliable = hash[:collidable]
      @texture = hash[:texture]
      @polygon.points.push(hash[:points].map { |pt| CyberarmEngine::Vector.new(pt[:x], pt[:y], 0, 0) })
      @polygon.color = hash[:color]
      @polygon.border_color = hash[:border_color]
      @polygon.border_thickness = hash[:border_thickness]

      @polygon.z = @type
    end

    def hash
      {
        id: @id,
        name: @name,
        type: @type,
        collidable: @colliable,
        texture: @texture,
        points: @polygon.points,
        color: @polygon.color,
        border_color: @polygon.border_color,
        border_thickness: @polygon.border_thickness
      }
    end

    def to_json(state)
      hash.to_json(state)
    end
  end
end
