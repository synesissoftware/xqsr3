
module Test
module Unit

module Assertions

	unless respond_to? :assert_eql
		def assert_eql(expected, actual, failure_message = nil)
			assert expected.eql?(actual), failure_message
		end
	end

end # class Assertions
end # module Unit
end # module Test


