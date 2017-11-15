
require 'xqsr3/hash_utilities/key_matching'

class Hash

	def has_match? re, **options

		return ::Xqsr3::HashUtilities::KeyMatching.has_match? self, re, **options
	end
end

