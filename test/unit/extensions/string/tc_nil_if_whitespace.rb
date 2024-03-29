#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/nil_if_whitespace'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'

class Test_String_nil_if_whitespace < Test::Unit::TestCase

  def test_String_has_method

    assert ''.respond_to? :nil_if_whitespace
  end

  def test_nil_if_whitespace

    assert_nil ''.nil_if_whitespace
    assert_nil ' '.nil_if_whitespace
    assert_equal 'a', 'a'.nil_if_whitespace
  end
end


