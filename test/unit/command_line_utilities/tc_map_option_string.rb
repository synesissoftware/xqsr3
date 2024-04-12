#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')


require 'xqsr3/command_line_utilities/map_option_string'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


include ::Xqsr3::CommandLineUtilities


class Test_Xqsr3_CommandLineUtilities_map_option_string < Test::Unit::TestCase

  def test_simple_uses

    assert_nil MapOptionString.map_option_string_from_string 'abc', [ 'option-1', 'option-2' ]

    assert_equal :abc, MapOptionString.map_option_string_from_string('abc', [ 'abc' ])

    assert_equal :option_1, MapOptionString.map_option_string_from_string('option-1', [ 'option-1', 'option-2' ])
  end

  def test_shortcuts

    option_strings = [ '[n]ame-only', '[f]ull-[p]ath' ]

    assert_equal :name_only, MapOptionString.map_option_string_from_string('name-only', option_strings)
    assert_equal :full_path, MapOptionString.map_option_string_from_string('full-path', option_strings)

    assert_equal :name_only, MapOptionString.map_option_string_from_string('n', option_strings)
    assert_equal :full_path, MapOptionString.map_option_string_from_string('fp', option_strings)

    %w{ a m e - o l y u l p a t h }.each do |shortcut|

      assert_nil MapOptionString.map_option_string_from_string(shortcut, option_strings)
    end
  end

  def test_nil

    assert_nil nil.map_option_string []
  end
end

