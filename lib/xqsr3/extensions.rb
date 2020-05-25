
%w{

	array
	enumerable
	hash
	io
}.each do |name|

	require File.join(File.dirname(__FILE__), 'extensions', name)
end


