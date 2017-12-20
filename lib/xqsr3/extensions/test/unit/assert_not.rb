
module Test
module Unit

module Assertions

	unless respond_to? :assert_not

		def assert_not(test, failure_message = '')

			assert !(test), failure_message
		end
	end

end # class Assertions
end # module Unit
end # module Test


