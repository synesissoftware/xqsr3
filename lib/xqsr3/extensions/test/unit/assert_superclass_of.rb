
require 'test/unit/assertions'


module Test
module Unit

module Assertions

  unless self.method_defined? :assert_superclass_of

    # Assert that +tested_class+ is a super-class of +child_class+
    def assert_superclass_of(child_class, tested_class, failure_message = nil)

      failure_message ||= "#{tested_class} is not a superclass of #{child_class}"

      assert(child_class < tested_class, failure_message)
    end
  end

end # class Assertions
end # module Unit
end # module Test

