#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/io/writelines'

require 'test/unit'
require 'stringio'

include ::Xqsr3::IO

class Test_Xqsr3_IO_writelines < Test::Unit::TestCase

	def test_single_string

		input = 'abc'

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_single_string_in_array

		input = [ 'abc' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_single_string_in_hash

		input = { 'abc' => '' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_two_strings_in_array

		input = [ 'abc', 'def' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 2, r
		assert_equal "abc\ndef\n", s.string
	end

	def test_two_strings_in_array_with_suppressed_eol

		input = [ 'abc', 'def' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input, line_separator: ''

		assert_equal 2, r
		assert_equal "abcdef", s.string
	end

	def test_two_strings_in_hash

		input = { 'ab' => 'c', 'de' => 'f' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 2, r
		assert_equal "abc\ndef\n", s.string
	end

	def test_two_strings_in_hash_with_col_sep

		input = { 'ab' => 'c', 'de' => 'f' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input, column_separator: "\t"

		assert_equal 2, r
		assert_equal "ab\tc\nde\tf\n", s.string
	end

	def test_ten_strings_in_array

		input = (0...10).map { |i| i.to_s }

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 10, r
		assert_equal "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n", s.string
	end

	def test_strings_with_cr_in_array

		input = [ "abc\n", "def\n", "ghi\n" ]

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 3, r
		assert_equal "abc\ndef\nghi\n", s.string
	end

	def test_strings_with_cr_in_array_and_line_sep

		input = [ "abc\n", "def\n", "ghi\n" ]

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input, line_separator: '|'

		assert_equal 3, r
		assert_equal "abc\n|def\n|ghi\n|", s.string
	end

	def test_many_strings_in_array_with_eol

		input = []

		(0...1000).each { |n| input << "entry-#{n.to_s().rjust(4, '0')}\n" }

		assert_equal 1000, input.size

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1000, r
		assert_equal "entry-0000\nentry-0001\n", s.string[0 ... 22]
	end

	def test_many_strings_in_array_without_eol

		input = []

		(0...1000).each { |n| input << "entry-#{n.to_s().rjust(4, '0')}" }

		assert_equal 1000, input.size

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1000, r
		assert_equal "entry-0000\nentry-0001\n", s.string[0 ... 22]
	end

	def test_many_strings_in_array_with_eol_and_line_sep

		input = []

		(0...1000).each { |n| input << "entry-#{n.to_s().rjust(4, '0')}\n" }

		assert_equal 1000, input.size

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input, line_separator: '|'

		assert_equal 1000, r
		assert_equal "entry-0000\n|entry-0001\n|", s.string[0 ... 24]
	end

	def test_many_strings_in_array_without_eol_and_line_sep

		input = []

		(0...1000).each { |n| input << "entry-#{n.to_s().rjust(4, '0')}" }

		assert_equal 1000, input.size

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input, line_separator: '|'

		assert_equal 1000, r
		assert_equal "entry-0000|entry-0001|", s.string[0 ... 22]
	end
end

