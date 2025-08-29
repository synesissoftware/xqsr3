#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/diagnostics/exceptions/with_cause'

require 'test/unit'


class Test_WithCause < Test::Unit::TestCase

  class SomeExceptionWithCause < ::Exception

    include ::Xqsr3::Diagnostics::Exceptions::WithCause
  end

  def test_no_ctor_args

    x = SomeExceptionWithCause.new

    assert_nil x.cause
    assert_equal SomeExceptionWithCause.to_s, x.message
    assert_equal SomeExceptionWithCause.to_s, x.chained_message
    assert_empty x.chainees
    assert_equal [ x ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_1_ctor_arg_that_is_a_message

    msg = 'stuff'

    x = SomeExceptionWithCause.new msg

    assert_nil x.cause
    assert_equal msg, x.message
    assert_equal msg, x.chained_message
    assert_empty x.chainees
    assert_equal [ x ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_1_ctor_arg_that_is_a_cause_and_has_no_message

    c = RuntimeError.new

    x = SomeExceptionWithCause.new c

    assert_not_nil x.cause
    assert_equal SomeExceptionWithCause.to_s, x.message
    assert_equal "#{SomeExceptionWithCause.to_s}: #{RuntimeError.to_s}", x.chained_message
    assert_not_empty x.chainees
    assert_equal [ c ], x.chainees
    assert_equal [ x, c ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_1_ctor_arg_that_is_a_cause_and_has_a_message

    c = RuntimeError.new 'blah'

    x = SomeExceptionWithCause.new c

    assert_not_nil x.cause
    assert_equal 'blah', x.message
    assert_equal 'blah', x.chained_message
    assert_not_empty x.chainees
    assert_equal [ c ], x.chainees
    assert_equal [ x, c ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_2_ctor_args_that_are_message_and_cause

    msg = 'stuff'

    c = RuntimeError.new

    x = SomeExceptionWithCause.new msg, c

    assert_not_nil x.cause
    assert_equal msg, x.message
    assert_equal "#{msg}: #{RuntimeError.to_s}", x.chained_message
    assert_not_empty x.chainees
    assert_equal [ c ], x.chainees
    assert_equal [ x, c ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_2_ctor_args_that_are_message_and_cause_that_has_a_message

    msg = 'stuff'

    c = RuntimeError.new 'blah'

    x = SomeExceptionWithCause.new msg, c

    assert_not_nil x.cause
    assert_equal msg, x.message
    assert_equal 'stuff: blah', x.chained_message

    assert_not_empty x.chainees
    assert_equal [ c ], x.chainees
    assert_equal [ x, c ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end

  def test_cause_in_options

    c = RuntimeError.new 'inner'

    x = SomeExceptionWithCause.new 'outer', cause: c

    assert_not_nil x.cause
    assert_equal 'outer', x.message
    assert_equal 'outer: inner', x.chained_message

    assert_not_empty x.chainees
    assert_equal [ c ], x.chainees
    assert_equal [ x, c ], x.exceptions
    assert_nil x.backtrace
    assert_empty x.options
  end



  class GrandchildException < Exception

    include ::Xqsr3::Diagnostics::Exceptions::WithCause
  end

  class ChildException < Exception

    def initialize(*args, **options)

      super(*args, **options)
    end

    include ::Xqsr3::Diagnostics::Exceptions::WithCause
  end

  class ParentException < Exception

    include ::Xqsr3::Diagnostics::Exceptions::WithCause

    def initialize(*args, **options)

      super(*args, **options)
    end
  end

  class GrandparentException < Exception

    include ::Xqsr3::Diagnostics::Exceptions::WithCause
  end


  def test_four_levels

    gc = GrandchildException.new 'gc'

    c = ChildException.new 'c', gc

    p = ParentException.new c, 'p'

    gp = GrandparentException.new 'gp', cause: p

    assert_equal 'gp: p: c: gc', gp.chained_message
    assert_equal 'gp-p-c-gc', gp.chained_message(separator: '-')
  end
end

class Test_WithCause_throwing < Test::Unit::TestCase

  class SomeExceptionWithCause < ::Exception

    include ::Xqsr3::Diagnostics::Exceptions::WithCause
  end

  def f m

    raise SomeExceptionWithCause, m
  end

  def g m, n

    begin

      f n
    rescue Exception => x

      raise SomeExceptionWithCause.new m, x
    end
  end

  def h m, n, o

    begin

      g n, 0
    rescue Exception => x

      raise SomeExceptionWithCause.new m, x
    end
  end

  def test_one_level

    begin

      f 'one-level'

      assert false, 'should not get here!'
    rescue Exception => x

      assert_nil x.cause
      assert_equal 'one-level', x.message
      assert_equal 'one-level', x.chained_message
      assert_empty x.chainees
      assert_not_empty x.backtrace

      x_bt0 = x.backtrace[0]

      re = /:\d+:in\s+\`f'\s*$/

      assert_match(re, x_bt0, "The received backtrace line '#{x_bt0}' in the exception received from `f()` did not match the expected pattern '#{re}'")
    end
  end

  def test_two_levels

    begin

      g 'two-levels', 'one-level'

      assert false, 'should not get here!'
    rescue Exception => x

      assert_not_nil x.cause
      assert_equal 'two-levels', x.message
      assert_equal 'two-levels: one-level', x.chained_message
      assert_not_empty x.chainees
      assert_kind_of SomeExceptionWithCause, x.chainees[0]
      assert_not_empty x.backtrace
      assert_not_empty x.cause.backtrace

      x_bt0 = x.backtrace[0]

      re_x = /:in\s+\`rescue in g\'\s*$/

      assert_match(re_x, x_bt0, "The received backtrace line '#{x_bt0}' in the exception received from `g()` did not match the expected pattern '#{re_x}'")

      c_bt0 = x.cause.backtrace[0]

      re_c = /:in\s+\`f\'\s*$/

      assert_match(re_c, c_bt0, "The received backtrace line '#{x_bt0}' in the exception received from `f()` (via `g()`) did not match the expected pattern '#{re_c}'")

      assert_not_empty x.chained_backtrace
    end
  end
end

