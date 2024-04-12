#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/enumerable/detect_map'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_Enumerable_detect_map < Test::Unit::TestCase

  def test_with_array

    assert_nil [].detect_map { |v| nil }
    assert_nil [ 1, 2, 3, 4, 5 ].detect_map { |v| nil }

    assert_nil [].detect_map { |v| :nil }
    assert_not_nil [ 1, 2, 3, 4, 5 ].detect_map { |v| :nil }

    assert_nil [].detect_map { |v| return -2 * v }
    assert_equal(-2, [ 1, 2, 3, 4, 5 ].detect_map { |v| -2 * v })
    assert_equal(-4, [ 1, 2, 3, 4, 5 ].detect_map { |v| -2 * v if 2 == v })
  end

  def test_with_hash

    h1 = {}
    h2 = { :abc => 'def', :ghi => 'jkl' }

    assert_nil h1.detect_map { |k, v| nil }
    assert_nil h2.detect_map { |k, v| nil }

    assert_nil h1.detect_map { |k, v| :nil }
    assert_not_nil h2.detect_map { |k, v| :nil }

    assert_nil h1.detect_map { |k, v| v.upcase }
    assert_equal 'DEF', h2.detect_map { |k, v| v.upcase }
    assert_equal 'JKL', h2.detect_map { |k, v| v.upcase if :ghi == k }
  end
end


