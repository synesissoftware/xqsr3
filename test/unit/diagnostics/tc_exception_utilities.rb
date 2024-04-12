#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')


require 'xqsr3/diagnostics/exception_utilities'

require 'test/unit'


class Test_ExceptionUtilities_raise_with_options < Test::Unit::TestCase

  include ::Xqsr3::Diagnostics

  OS_IS_WINDOWS = (RUBY_PLATFORM =~ /(mswin|mingw|bccwin|wince)/i) ? true : false
  LINE_NUM_RE   = OS_IS_WINDOWS ? /.+:(\d+):/ : /^[^:]+:(\d+)/

  class ArgumentErrorWithOptions < ArgumentError
    def initialize(message = nil, **options)
      super(message)
      options ||= {}
      @options = options
    end
    attr_reader :options

    def exception(msg = nil, options = nil)

      return self if msg.nil?
      return self if msg.object_id == self.object_id

      msg ||= self.message
      options ||= {}
      r = self.class.new msg, **self.options.merge(options)
      r
    end
  end

  def execute(&block)

    block.call
  end

  def test_0

    # standard raise: message-only
    begin
      raise "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(RuntimeError, x)
      assert_equal "abc", x.message
    end

    # RWO: message-only
    begin
      ExceptionUtilities.raise_with_options "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(RuntimeError, x)
      assert_equal "abc", x.message
    end
  end

  def test_1

    # standard raise: class
    begin
      raise ArgumentError

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "ArgumentError", x.message
    end

    # RWO: class + message
    begin
      ExceptionUtilities.raise_with_options ArgumentError

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "ArgumentError", x.message
    end
  end

  def test_2

    # standard raise: class + message
    begin
      raise ArgumentError, "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
    end

    # RWO: class + message
    begin
      ExceptionUtilities.raise_with_options ArgumentError, "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
    end
  end

  def test_2_b_no_options

    # standard raise: class + message
    begin
      raise ArgumentErrorWithOptions, "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
    end

    # RWO: class + message
    begin
      ExceptionUtilities.raise_with_options ArgumentErrorWithOptions, "abc"

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
    end
  end

  def test_2_b_with_options

    # standard raise: class + message + options
    begin
      raise ArgumentErrorWithOptions.new("abc", blah: :blech, id: 23)

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
      assert_equal ({ :blah => :blech, :id => 23 }), x.options
    end

    # RWO: class + message + options (raise-way)
    begin
      ExceptionUtilities.raise_with_options ArgumentErrorWithOptions.new("abc", blah: :blech, id: 23)

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
      assert_equal ({ :blah => :blech, :id => 23 }), x.options
    end

    # RWO: class + message + options (raise_with_options-way)
    begin
      ExceptionUtilities.raise_with_options ArgumentErrorWithOptions, "abc", blah: :blech, id: 23

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
      assert_equal ({ :blah => :blech, :id => 23 }), x.options
    end
  end


  def test_with_backtrace
    line_number = nil

    # standard raise: class + message + stack trace
    begin
      begin
        execute { line_number = __LINE__; raise ArgumentError }
      rescue => x
        raise x, "abc", x.backtrace
      end

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message


      assert $@[0] =~ LINE_NUM_RE
      assert_equal line_number.to_s, $1.to_s
    end

    # RWO: class + message + stack trace
    begin
      begin
        execute { line_number = __LINE__; ExceptionUtilities.raise_with_options ArgumentErrorWithOptions, blah: :blech, id: 23 }

        assert false, "should not get here"
      rescue => x
        raise x, "abc", x.backtrace
      end

      assert false, "should not get here"
    rescue => x

      assert_kind_of(ArgumentError, x)
      assert_equal "abc", x.message
      assert_equal ({ :blah => :blech, :id => 23 }), x.options

      assert $@[0] =~ LINE_NUM_RE
      assert_equal line_number.to_s, $1.to_s
    end
  end
end

