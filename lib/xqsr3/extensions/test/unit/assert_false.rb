
module Test
module Unit

module Assertions

	unless respond_to? :assert_false

		# Assert that +expression+ is +false+ (and not merely _falsey_)
		def assert_false(expression, failure_message = '')

			assert ::FalseClass === (expression), failure_message
		end
	end

end # class Assertions
end # module Unit
end # module Test

