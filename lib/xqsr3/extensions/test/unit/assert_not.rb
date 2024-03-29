
module Test
module Unit

module Assertions

  unless respond_to? :assert_not

    # Assert that +expression+ is _falsey_
    def assert_not(expression, failure_message = '')

      assert !(expression), failure_message
    end
  end

end # class Assertions
end # module Unit
end # module Test


