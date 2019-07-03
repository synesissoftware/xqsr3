
require 'xqsr3/extensions/hash/deep_transform'
require 'xqsr3/extensions/hash/has_match'
require 'xqsr3/extensions/hash/match'

unless (RUBY_VERSION.split('.').map { |v| v.to_i } <=> [ 2, 5, 0 ]) > 0

	require 'xqsr3/extensions/hash/slice'
end

