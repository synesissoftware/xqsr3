#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')


require 'xqsr3/string_utilities/truncate'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_StringUtilities_Truncate < ::Test::Unit::TestCase

  Truncator = ::Xqsr3::StringUtilities::Truncate

  def test_truncate_of_empty_string

    assert_equal '', Truncator.string_truncate('', 0)
    assert_equal '', Truncator.string_truncate('', 1)
    assert_equal '', Truncator.string_truncate('', 10)
  end

  def test_truncate_of_smallest_string

    assert_equal '', Truncator.string_truncate('a', 0)
    assert_equal 'a', Truncator.string_truncate('a', 1)
    assert_equal 'a', Truncator.string_truncate('a', 10)
  end

  def test_truncate_of_smaller_string

    assert_equal '', Truncator.string_truncate('abc', 0)
    assert_equal '.', Truncator.string_truncate('abc', 1)
    assert_equal '..', Truncator.string_truncate('abc', 2)
    assert_equal 'abc', Truncator.string_truncate('abc', 3)
    assert_equal 'abc', Truncator.string_truncate('abc', 4)
    assert_equal 'abc', Truncator.string_truncate('abc', 10)
  end

  def test_truncate_of_small_string

    assert_equal '', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 0)
    assert_equal '.', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 1)
    assert_equal '..', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 2)
    assert_equal '...', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 3)
    assert_equal 'a...', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 4)
    assert_equal 'abcdefg...', Truncator.string_truncate('abcdefghijklmnopqrstuvwxyz', 10)
  end


end

