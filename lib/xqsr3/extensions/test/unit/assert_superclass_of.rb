
module Test
module Unit

module Assertions

	unless respond_to? :assert_superclass_of

		def assert_superclass_of(child_class, tested_class, failure_message = nil)

			failure_message ||= "#{tested_class} is not a superclass of #{child_class}"

			assert(child_class < tested_class, failure_message)
		end
	end

end # class Assertions
end # module Unit
end # module Test


