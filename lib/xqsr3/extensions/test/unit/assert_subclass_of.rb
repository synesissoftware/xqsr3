
require 'test/unit/assertions'


module Test
module Unit

module Assertions

  unless self.method_defined? :assert_subclass_of

    # Assert that +tested_class+ is a sub-class of +parent_class+
    def assert_subclass_of(parent_class, tested_class, failure_message = nil)

      failure_message ||= "#{tested_class} is not a subclass of #{parent_class}"

      assert(tested_class < parent_class, failure_message)
    end
  end

end # class Assertions
end # module Unit
end # module Test

