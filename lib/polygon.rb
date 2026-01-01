module IMICTDS
  class Polygon
    attr_reader :points, :points_count, :triangles, :debug_colors
    attr_accessor :color, :border_color, :border_size, :z

    def initialize(points, z = 0, color = Gosu::Color::WHITE, border_color = Gosu::Color::TRANSPARENT, border_size = 0)
      @points = points
      @z = z
      @color = color
      @border_color = border_color
      @border_size = border_size

      @triangles = []

      @triangulated = false
      @points_count = @points.size

      @debug_colors = 256.times.to_a.map do
        Gosu::Color.new(200, rand(100..255), rand(100..255), rand(100..255))
      end
    end

    # Ear-Clipping Triangulation / Two Ear Theorem
    def triangulate
      return if @points.size < 3

      @triangles.clear
      puts "GENERATING..."
      t = IMICTDS.milliseconds
      list = @points.dup
      list = list.reverse unless clockwise?(list)

      i = 1
      last_eared = 0
      while list.size > 3
        a = list[i % list.size]
        b = list[(i + 1) % list.size]
        c = list[(i + 2) % list.size]
        ear = false

        if angle(a, b, c) < Math::PI
          ear = true

          ((list.size + i + 3) - (i + 3)).times do |j|
            j += 3

            if point_inside_triangle?(list[j % list.size], [a, b, c])
              ear = false
              break
            end
          end

          if ear
            list.delete(b)

            @triangles << [a, b, c]
            last_eared = 0
            puts "T: #{@triangles.size}"
          else
            last_eared += 1

            # If an ear isn't found after loop through whole list, then break to prevent infinite loop
            if last_eared > @points.size * 2
              puts "WARN: Aborted due to infinite loop risk!"

              break
            end
          end
        end

        i += 1
      end

      @triangulated = true
      @points_count = @points.size
      puts "Took: #{IMICTDS.milliseconds - t}ms" # !server unsafe
    end

    def angle(a, b, c)
      x = Math.atan2(c.y - b.y, c.x - b.x) - Math.atan2(a.y - b.y, a.x - b.x)

      x < 0 ? Math::PI * 2 + x : x
    end

    def triangulated?
      @triangulated
    end

    def point_inside?(vector)
      @triangles.find { |t| point_inside_triangle?(vector, t) }
    end

    def point_inside_triangle?(pt, tri)
      a = tri[0]
      b = tri[1]
      c = tri[2]

      area_a = triangle_area([a, b, pt])
      area_b = triangle_area([b, c, pt])
      area_c = triangle_area([c, a, pt])

      sign(area_a) == sign(area_b) && sign(area_a) == sign(area_c)
    end

    def sign(n)
      if n.negative?
        -1
      elsif n.positive?
        1
      else
        n
      end
    end

    def triangle_area(tri)
      a = tri[0]
      b = tri[1]
      c = tri[2]

      (a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y)) / 2
    end

    def clockwise?(pts = @points)
      sum = 0

      pts.each_with_index do |a, i|
        b = pts[i + 1] || pts[0]

        sum += (b.x - a.x) * (b.y + a.y)
      end

      sum >= 0
    end
  end
end
