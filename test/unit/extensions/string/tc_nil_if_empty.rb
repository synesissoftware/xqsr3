#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/string/nil_if_empty'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'


class Test_String_nil_if_empty < Test::Unit::TestCase

  def test_String_has_method

    assert ''.respond_to? :nil_if_empty
  end

  def test_nil_if_empty

    assert_nil ''.nil_if_empty
    assert_equal ' ', ' '.nil_if_empty
    assert_equal 'a', 'a'.nil_if_empty
  end
end


