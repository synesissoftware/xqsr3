
require 'xqsr3/conversion/bool_parser'

class String

	def to_bool **options

		return ::Xqsr3::Conversion::BoolParser.to_bool self, **options
	end
end # class String


