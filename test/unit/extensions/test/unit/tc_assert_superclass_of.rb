#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..']*5), 'lib')

require 'xqsr3/extensions/test/unit/assert_superclass_of'

require 'test/unit'

class Test_assert_superclass_of < Test::Unit::TestCase

	class Grandparent; end
	class Parent < Grandparent; end
	class Child < Parent; end

	def test_1

		assert_superclass_of Grandparent, Object
		assert_superclass_of Parent, Grandparent
		assert_superclass_of Child, Parent
		assert_superclass_of Child, Grandparent
	end
end


