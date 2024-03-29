
%w{

  bool_parser
  integer_parser
}.each do |name|

  require File.join(File.dirname(__FILE__), 'conversion', name)
end


