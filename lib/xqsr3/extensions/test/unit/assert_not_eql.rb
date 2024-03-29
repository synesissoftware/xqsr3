
module Test
module Unit

module Assertions

  unless respond_to? :assert_not_eql

    # Assert that +expected+ and +actual+ have different hash keys
    def assert_not_eql(expected, actual, failure_message = '')

      assert !(expected.eql?(actual)), failure_message
    end
  end

end # class Assertions
end # module Unit
end # module Test


