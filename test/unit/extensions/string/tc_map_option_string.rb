#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/map_option_string'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_String_map_option_string < Test::Unit::TestCase

	def test_simple_uses

		assert_nil 'abc'.map_option_string [ 'option-1', 'option-2' ]

		assert_equal :abc, 'abc'.map_option_string([ 'abc' ])

		assert_equal :option_1, 'option-1'.map_option_string([ 'option-1', 'option-2' ])
	end

	def test_shortcuts

		option_strings = [ '[n]ame-only', '[f]ull-[p]ath' ]

		assert_equal :name_only, 'name-only'.map_option_string(option_strings)
		assert_equal :full_path, 'full-path'.map_option_string(option_strings)

		assert_equal :name_only, 'n'.map_option_string(option_strings)
		assert_equal :full_path, 'fp'.map_option_string(option_strings)

		%w{ a m e - o l y u l p a t h }.each do |shortcut|

			assert_nil shortcut.map_option_string(option_strings)
		end
	end
end

