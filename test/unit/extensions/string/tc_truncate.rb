#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/string/truncate'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_String_truncate < Test::Unit::TestCase

  def test_empty_string

    assert_equal '', ''.truncate(0)
    assert_equal '', ''.truncate(1)
    assert_equal '', ''.truncate(10)
  end

  def test_short_string

    assert_equal '.', 'ab'.truncate(1)
    assert_equal 'ab', 'ab'.truncate(2)
    assert_equal 'ab', 'ab'.truncate(10)
  end

  def test_shortish_string

    assert_equal '.', 'abcde'.truncate(1)
    assert_equal '..', 'abcde'.truncate(2)
    assert_equal '...', 'abcde'.truncate(3)
    assert_equal 'a...', 'abcde'.truncate(4)
    assert_equal 'abcde', 'abcde'.truncate(5)
    assert_equal 'abcde', 'abcde'.truncate(10)
  end
end


