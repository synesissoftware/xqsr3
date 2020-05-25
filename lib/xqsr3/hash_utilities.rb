
%w{

	deep_transform
	key_matching
}.each do |name|

	require File.join(File.dirname(__FILE__), 'hash_utilities', name)
end


