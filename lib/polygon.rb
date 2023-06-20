module IMICTDS
  class Polygon
    include CyberarmEngine::Common

    attr_reader :points

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
      t = Gosu.milliseconds # !server unsafe
      list = @points.dup
      list = list.reverse unless clockwise?(list)

      i = 1
      last_eared = 0
      while list.size > 3
        a = list[i % list.size]
        b = list[(i + 1) % list.size]
        c = list[(i + 2) % list.size]
        ear = false

        if (angle(a, b, c) < Math::PI)
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
      puts "Took: #{Gosu.milliseconds - t}ms" # !server unsafe
    end

    def draw
      @triangulated = false if @points.size != @points_count

      triangulate unless @triangulated

      @triangles.each_with_index do |t, i|
        a = t[0]
        b = t[1]
        c = t[2]

        color = point_inside_triangle?(CyberarmEngine::Vector.new(window.mouse_x, window.mouse_y), t) ? @color : @debug_colors[i]

        Gosu.draw_triangle(
          a.x, a.y, color,
          b.x, b.y, color,
          c.x, c.y, color,
          @z
        )
      end

      return if @border_size.zero? || @points_count < 2

      # TODO: Draw polygon border (using rects so that it can have thickness)
      anchor_point = @points.first
      @points[1...].each do |point|
        Gosu.draw_line(
          anchor_point.x, anchor_point.y, @border_color,
          point.x, point.y, @border_color,
          @z
        )

        anchor_point = point
      end
    end

    def angle(a, b, c)
      x = Math.atan2((c.y - b.y), (c.x - b.x)) - Math.atan2((a.y - b.y), (a.x - b.x))

      x < 0 ? Math::PI * 2 + x : x
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

      (sign(area_a) == sign(area_b) && sign(area_a) == sign(area_c))
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
        b = pts[i + 1] ? pts[i + 1] : pts[0]

        sum += (b.x - a.x) * (b.y + a.y)
      end

      return sum >= 0
    end
  end
end
