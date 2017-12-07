
require 'xqsr3/array_utilities/join_with_or'

class Array

	def join_with_or **options

		return ::Xqsr3::ArrayUtilities::JoinWithOr.join_with_or self, **options
	end
end


