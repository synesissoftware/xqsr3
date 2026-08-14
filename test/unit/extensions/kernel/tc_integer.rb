#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/kernel/integer'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_X_Kernel_Integer < Test::Unit::TestCase

  class SomeRandomException < Exception; end

  def test_Integer_with_valid_values

    assert_equal(0, Integer(0))
    assert_equal(+1, Integer(1))
    assert_equal(+1, Integer(+1))
    assert_equal(-1, Integer(-1))

    assert_equal(0, Integer('0'))
    assert_equal(+1, Integer('1'))
    assert_equal(+1, Integer('+1'))
    assert_equal(-1, Integer('-1'))
  end

  def test_Integer_with_base

    assert_equal 16, Integer('10', 16)
    assert_equal 8, Integer('10', 8)
    assert_equal 10, Integer('10', 10)
    assert_equal 2, Integer('10', 2)
    assert_equal 255, Integer('ff', 16)
    assert_equal 255, Integer('FF', 16)
  end

  def test_Integer_with_base_and_options

    assert_equal 16, Integer('10', 16, default: 0)
    assert_equal 0, Integer('gg', 16, default: 0)
    assert_nil Integer('gg', 16, nil: true)
  end

  def test_Integer_with_invalid_values

    assert_raise(TypeError) { Integer nil }
    assert_raise(ArgumentError) { Integer '' }
    assert_raise(ArgumentError) { Integer 'abc' }
    assert_raise(ArgumentError) { Integer 'zero' }
    assert_raise(ArgumentError) { Integer 'plus 1' }
    assert_raise(ArgumentError) { Integer '/0' }
  end

  def test_Integer_with_invalid_values_returning_nil

    assert_nil Integer(nil, nil: true)
    assert_nil Integer('', nil: true)
    assert_nil Integer('abc', nil: true)
    assert_nil Integer('zero', nil: true)
    assert_nil Integer('plus 1', nil: true)
    assert_nil Integer('/0', nil: true)
  end

  def test_Integer_with_invalid_values_returning_0

    assert_equal 0, Integer(nil, default: 0)
    assert_equal 0, Integer('', default: 0)
    assert_equal 0, Integer('abc', default: 0)
    assert_equal 0, Integer('zero', default: 0)
    assert_equal 0, Integer('plus 1', default: 0)
    assert_equal 0, Integer('/0', default: 0)
  end

  def test_Integer_with_invalid_values_returning_sentinel

    assert_equal :sentinel, Integer(nil, default: :sentinel)
    assert_equal :sentinel, Integer('', default: :sentinel)
    assert_equal :sentinel, Integer('abc', default: :sentinel)
    assert_equal :sentinel, Integer('zero', default: :sentinel)
    assert_equal :sentinel, Integer('plus 1', default: :sentinel)
    assert_equal :sentinel, Integer('/0', default: :sentinel)
  end

  def test_Integer_with_invalid_values_returning_sentinel_of_nil

    assert_equal nil, Integer(nil, default: nil)
    assert_equal nil, Integer('', default: nil)
    assert_equal nil, Integer('abc', default: nil)
    assert_equal nil, Integer('zero', default: nil)
    assert_equal nil, Integer('plus 1', default: nil)
    assert_equal nil, Integer('/0', default: nil)
  end

  def test_Integer_with_invalid_values_and_block

    assert_equal nil, Integer(nil) { nil }
    assert_equal nil, Integer('blah') { nil }

    assert_equal 'one', Integer(nil) { 'one' }
    assert_equal 'one', Integer('blah') { 'one' }

    assert_raise(SomeRandomException) { Integer(nil) { raise SomeRandomException.new } }
  end
end


