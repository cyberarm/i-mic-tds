module IMICTDS
  module MapEditor
    # Command pattern, anyone?
    class Command
      attr_reader :hash

      def initialize(hash)
        @hash = hash
      end

      def commit; end

      def revert; end
    end
  end
end
