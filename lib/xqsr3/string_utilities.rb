
%w{

  ends_with
  nil_if_empty
  nil_if_whitespace
  quote_if
  starts_with
  to_symbol
  truncate
}.each do |name|

  require File.join(File.dirname(__FILE__), 'string_utilities', name)
end


