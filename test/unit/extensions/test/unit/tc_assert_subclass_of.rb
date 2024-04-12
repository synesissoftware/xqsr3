#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..']*5), 'lib')

require 'xqsr3/extensions/test/unit/assert_subclass_of'

require 'test/unit'

class Test_assert_subclass_of < Test::Unit::TestCase

  class Grandparent; end
  class Parent < Grandparent; end
  class Child < Parent; end

  def test_1

    assert_subclass_of Object, Grandparent
    assert_subclass_of Grandparent, Parent
    assert_subclass_of Parent, Child
    assert_subclass_of Grandparent, Child
  end
end


