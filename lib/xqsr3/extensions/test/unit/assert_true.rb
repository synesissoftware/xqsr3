
require 'test/unit/assertions'


module Test
module Unit

  module Assertions

    unless self.method_defined? :assert_true

      # Assert that +expression+ is +true+ (and not merely _truey_)
      def assert_true(expression, failure_message = '')

        assert ::TrueClass === (expression), failure_message
      end
    end
  end # class Assertions
end # module Unit
end # module Test

