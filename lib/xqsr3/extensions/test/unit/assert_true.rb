
module Test
module Unit

module Assertions

	unless respond_to? :assert_true

		def assert_true(expression, failure_message = '')

			assert (expression), failure_message
		end
	end

end # class Assertions
end # module Unit
end # module Test



