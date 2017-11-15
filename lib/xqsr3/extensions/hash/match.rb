
require 'xqsr3/hash_utilities/key_matching'

class Hash

	def match re, **options

		return ::Xqsr3::HashUtilities::KeyMatching.match self, re, **options
	end
end

