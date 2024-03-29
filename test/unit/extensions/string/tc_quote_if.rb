#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/quote_if'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'

class Test_String_quote_if < Test::Unit::TestCase

  def test_String_has_method

    assert ''.respond_to? :quote_if
  end

  def test_with_no_options

    assert_equal '', ''.quote_if
    assert_equal 'a', 'a'.quote_if
    assert_equal 'ab', 'ab'.quote_if
    assert_equal '"a b"', 'a b'.quote_if
  end

  def test_with_quotables

    assert_equal 'a b', 'a b'.quote_if(quotables: '-')
    assert_equal '"a-b"', 'a-b'.quote_if(quotables: '-')
  end

  def test_with_quotes

    assert_equal '"a b"', 'a b'.quote_if
    assert_equal '|a b|', 'a b'.quote_if(quotes: '|')
    assert_equal '[a b]', 'a b'.quote_if(quotes: [ '[', ']' ])
  end
end



