#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..']*5), 'lib')

require 'xqsr3/extensions/test/unit/assert_raise_with_message'

require 'test/unit'

class Test_assert_raise_with_message < Test::Unit::TestCase

  def test_no_class_and_specific_message

    assert_raise_with_message(nil, 'the-message') { raise ArgumentError, 'the-message' }
  end

  def test_no_class_and_message_list

    assert_raise_with_message(nil, [ 'first-message', 'a-message', 'the-message', 'last-message' ]) { raise ArgumentError, 'the-message' }
  end

  def test_specific_class_and_no_message

    assert_raise_with_message(::ArgumentError, nil) { raise ::ArgumentError, 'the-message' }
  end

  def test_class_list_and_no_message

    assert_raise_with_message([ ::ArgumentError, ::SystemExit ], nil) { raise ::ArgumentError, 'the-message' }
    assert_raise_with_message([ ::SystemExit, ::ArgumentError ], nil) { raise ::ArgumentError, 'the-message' }
  end

  def test_class_and_regex_message

    assert_raise_with_message(::RuntimeError, /the.*message/) { raise 'the-longer-message' }
  end
end


