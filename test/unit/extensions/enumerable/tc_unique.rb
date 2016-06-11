#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/enumerable/unique'

require 'test/unit'

class Test_Enumerable_unique_test < Test::Unit::TestCase

	def test_empty

		src = []

		dest = src.unique

		assert dest.empty?
	end

	def test_already_unique

		src = [ 1, 2, 3, 4 ]

		dest = src.unique

		assert_equal src, dest
	end

	def test_unique_contiguous

		src = [ 1, 2, 3, 3, 4 ]

		dest = src.unique

		assert_equal [ 1, 2, 3, 4], dest
	end

	def test_unique_noncontiguous

		src = [ 1, 2, 3, 4, 3 ]

		dest = src.unique

		assert_equal [ 1, 2, 3, 4], dest
	end
end

