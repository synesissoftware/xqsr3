
require 'test/unit/assertions'


module Test
module Unit

module Assertions

  unless self.method_defined? :assert_eql

    # Assert that +expected+ and +actual+ have the same hash key, as
    # evaluated by the instance method +eq?+
    def assert_eql(expected, actual, failure_message = '')

      assert expected.eql?(actual), failure_message
    end
  end

end # class Assertions
end # module Unit
end # module Test

