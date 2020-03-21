module Core
  module Exceptions
    class ArgumentError < StandardError
      def initialize(msg = 'Invalid Argument')
        super
      end
    end
  end
end
