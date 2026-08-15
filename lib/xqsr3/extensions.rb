# frozen_string_literal: true

%w{

  array
  enumerable
  hash
  integer
  io
  kernel
  string
}.each do |name|

  require File.join(File.dirname(__FILE__), 'extensions', name)
end


