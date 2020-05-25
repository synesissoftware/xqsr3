
%w{

	frequency_map
	multi_map
}.each do |name|

	require File.join(File.dirname(__FILE__), 'containers', name)
end


