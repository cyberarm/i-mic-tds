module IMICTDS
  # Port of mapbox's earcut.hpp to Ruby
  # https://github.com/mapbox/earcut.hpp/blob/master/include/mapbox/earcut.hpp
  class Earcut
    def initialize(polygon)
      @polygon = polygon # IMICTDS::Polygon

      @indices = []
      @vertices = 0
    end

    def process
      return if @polygon.points.empty?

      x = 0
      y = 0
      threshold = 80
    end

    class Node
      attr_accessor :index, :x, :y,
                    :prev, :next, :z, :steiner, :prev_z, :next_z
      def initialize(index, x, y)
        @index = index
        @x = x
        @y = y


        @prev = nil
        @next = nil
        @z = 0
        @steiner = false
        @prev_z = nil
        @next_z = nil
      end
    end

    class Triangle
      def initialize(node_a, node_b, node_c)
        @ax = node_a.x
        @ay = node_a.y

        @bx = node_b.x
        @by = node_b.y

        @cx = node_c.x
        @cy = node_c.y
      end

      def area
        (@by - @ay) * (@cx - @bx) - (@bx - @ax) * (@cy - @by)
      end

      def contains_point?(x, y)
        (@cx - x) * (@ay - y) >= (@ax - x) * (@cy - y) &&
        (@ax - x) * (@by - y) >= (@bx - x) * (@ay - y) &&
        (@bx - x) * (@cy - y) >= (@cx - x) * (@by - y)
      end
  end
end
