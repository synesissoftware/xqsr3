#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/conversion/integer_parser'

require 'xqsr3/extensions/test/unit'

require 'test/unit'

class Test_IntegerParser < Test::Unit::TestCase

  IP = ::Xqsr3::Conversion::IntegerParser

  class SomeRandomException < Exception; end

  def test_show_base_being_ignored

    assert_equal(-100, IP.to_integer(-100))
    assert_equal(-100, IP.to_integer(-100, 0))
    assert_equal(-100, IP.to_integer(-100.0, 0))
    assert_equal(-100, IP.to_integer(-100.0, 10))

    assert_equal(-100, IP.to_integer('-100'))
    assert_equal(-100, IP.to_integer('-100', 0))
    assert_equal(-100, IP.to_integer('-100', 10))
    assert_equal(-4, IP.to_integer('-100', 2))
  end

  def test_default_for_invalid_type

    assert_equal 12345, IP.to_integer(12..345, default: 12345)
  end

  def test_to_integer_with_valid_values

    assert_equal(0, IP.to_integer(0))
    assert_equal(+1, IP.to_integer(1))
    assert_equal(+1, IP.to_integer(+1))
    assert_equal(-1, IP.to_integer(-1))

    assert_equal(0, IP.to_integer('0'))
    assert_equal(+1, IP.to_integer('1'))
    assert_equal(+1, IP.to_integer('+1'))
    assert_equal(-1, IP.to_integer('-1'))
  end

  def test_to_integer_with_invalid_values

    assert_raise(TypeError) { IP.to_integer nil }
    assert_raise(ArgumentError) { IP.to_integer '' }
    assert_raise(ArgumentError) { IP.to_integer 'abc' }
    assert_raise(ArgumentError) { IP.to_integer 'zero' }
    assert_raise(ArgumentError) { IP.to_integer 'plus 1' }
    assert_raise(ArgumentError) { IP.to_integer '/0' }
  end

  def test_to_integer_with_invalid_values_returning_nil

    assert_nil IP.to_integer(nil, nil: true)
    assert_nil IP.to_integer('', nil: true)
    assert_nil IP.to_integer('abc', nil: true)
    assert_nil IP.to_integer('zero', nil: true)
    assert_nil IP.to_integer('plus 1', nil: true)
    assert_nil IP.to_integer('/0', nil: true)
  end

  def test_to_integer_with_invalid_values_returning_0

    assert_equal 0, IP.to_integer(nil, default: 0)
    assert_equal 0, IP.to_integer('', default: 0)
    assert_equal 0, IP.to_integer('abc', default: 0)
    assert_equal 0, IP.to_integer('zero', default: 0)
    assert_equal 0, IP.to_integer('plus 1', default: 0)
    assert_equal 0, IP.to_integer('/0', default: 0)
  end

  def test_to_integer_with_invalid_values_returning_sentinel

    assert_equal :sentinel, IP.to_integer(nil, default: :sentinel)
    assert_equal :sentinel, IP.to_integer('', default: :sentinel)
    assert_equal :sentinel, IP.to_integer('abc', default: :sentinel)
    assert_equal :sentinel, IP.to_integer('zero', default: :sentinel)
    assert_equal :sentinel, IP.to_integer('plus 1', default: :sentinel)
    assert_equal :sentinel, IP.to_integer('/0', default: :sentinel)
  end

  def test_to_integer_with_invalid_values_returning_sentinel_of_nil

    assert_equal nil, IP.to_integer(nil, default: nil)
    assert_equal nil, IP.to_integer('', default: nil)
    assert_equal nil, IP.to_integer('abc', default: nil)
    assert_equal nil, IP.to_integer('zero', default: nil)
    assert_equal nil, IP.to_integer('plus 1', default: nil)
    assert_equal nil, IP.to_integer('/0', default: nil)
  end

  def test_to_integer_with_invalid_values_and_block

    assert_equal nil, IP.to_integer(nil) { nil }
    assert_equal nil, IP.to_integer('blah') { nil }

    assert_equal 'one', IP.to_integer(nil) { 'one' }
    assert_equal 'one', IP.to_integer('blah') { 'one' }

    assert_raise(SomeRandomException) { IP.to_integer(nil) { raise SomeRandomException.new } }
  end
end


