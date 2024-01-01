
require 'xqsr3/conversion/bool_parser'

class String

	# Attempts to convert instance to a Boolean value, based on the given
	# +options+
	#
	# See Xqsr3::Conversion::BoolParser
	def to_bool **options

		return ::Xqsr3::Conversion::BoolParser.to_bool self, **options
	end
end # class String

