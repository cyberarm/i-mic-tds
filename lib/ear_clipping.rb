module IMICTDS
  # https://freder.github.io/UnityGraphicsProgrammingBook1/html-translated/vol4/Chapter%205%20_%20Triangulation%20by%20Ear%20Clipping.html
  module EarClipping
    class TreeNode
      attr_accessor :parent, :value
      attr_reader :children

      def initialize(value = nil)
        @parent = nil
        @children = []

        @value = value
      end

      def add_child(tree_or_value)
        if tree_or_value.is_a?(TreeNode)
          children.push(tree_or_value)
          tree_or_value.parent = self
        else
          add_child(TreeNode.new(tree_or_value))
        end
      end

      def remove_child(tree)
        if (node = @children.find(tree))
          @children.delete(node)
          tree.parent = nil
        end
      end
    end

    XMaxData = Data.new(:xmax, :polygon_index, :xmax_index)

    class Triangulation
      def initialize
        @vertices = []
        @indices = []
        @ear_tips = []
        @polygons = []
      end

      def add_polygon(polygon)
        @polygons << polygon
      end

      def triangluate
        @polygons.sort! do |a, b|
          (b.rect.width * b.rect.height) - (a.rect.width * a.rect.height)
        end

        tree = TreeNode.new

        @polygons.each do |polygon|
          check_polygon_in_tree(tree, polygon, 1)
        end
      end

      def check_polygon_in_tree(tree, polygon, level)
        child = false

        return false if tree.value && !tree.value.point_in_polygon(polygon)

        tree.children.each do |subtree|
          child |= check_polygon_in_tree(subtree, polygon, level + 1)
        end

        unless child
          polygon.indices.reverse! if (level.even? && polygon.clockwise?) || (level.odd? && !polygon.clockwise?)

          tree.children.add(TreeNode.new(polygon))
          return true
        end

        child
      end

      def combine_outer_and_inners(outer, inners)
        pairs = []

        inners.each_with_index do |inner, i|
          xmax = inner.points.first.x
          xmax_index = 0

          inner.points.each_with_index do |point, j|
            if point.x > xmax
              xmax = point.x
              xmax_index = j
            end
          end

          pairs << XMaxData.new(xmax, i, xmax_index)
        end

        pairs.sort { |a, b| (b.xmax - a.xmax).floor }.each do |pair|
          outer = combine_polygon(outer, inners[pair.polygon_index], pair.xmax_index)
        end

        outer
      end

      def combine_polygon(outer, inner, xmax_index); end

      def ear_clipping
        while @ear_tips.size.positive?
        end
      end
    end
  end
end
