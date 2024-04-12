#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../lib')

require 'xqsr3/extensions/test/unit/assert_raise_with_message'

require 'test/unit'

class Test_assert_raise_with_message < Test::Unit::TestCase

  class UnusedException < RuntimeError; end

  class TestException < RuntimeError; end

  def test_1

    assert_raise_with_message(UnusedException, "abc") { raise TestException, 'abc' }
  end

  def test_2

    assert_raise_with_message(TestException, "abcd") { raise TestException, 'abc' }
  end

  def test_3

    assert_raise_with_message(TestException, /abc$/) { raise TestException, 'abcd' }
  end
end

