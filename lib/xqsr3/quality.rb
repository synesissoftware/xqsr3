
%w{

  parameter_checking
}.each do |name|

  require File.join(File.dirname(__FILE__), 'quality', name)
end


