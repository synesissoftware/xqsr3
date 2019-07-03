#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/hash/slice'

class Test_Hash_slice < Test::Unit::TestCase

	def test_empty

		assert_equal ({}), ({}.slice())

		assert_equal ({}), ({}.slice(:abc, 'def'))
	end

	def test_none_matching

		assert_equal ({}), ({ abc: 'abc', 'def' => :def }.slice())
	end

	def test_all_matching

		assert_equal ({ abc: 'abc', 'def' => :def }), ({ abc: 'abc', 'def' => :def }.slice(:abc, 'def'))
	end

	def test_some_matching

		assert_equal ({ abc: 'abc' }), ({ abc: 'abc', 'def' => :def }.slice(:abc, 'ghi'))
	end
end

