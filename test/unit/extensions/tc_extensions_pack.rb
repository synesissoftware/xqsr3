#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')


require 'xqsr3/extensions'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_Xqsr3_extensions_pack < Test::Unit::TestCase

  def test_extensions_pack_loads_documented_surfaces

    assert [].respond_to?(:join_with_or)
    assert [].respond_to?(:collect_with_index)
    assert [].respond_to?(:detect_map)
    assert [].respond_to?(:unique)
    assert Hash.new.respond_to?(:deep_transform)
    assert 1234.respond_to?(:to_s_grp)
    assert ::IO.respond_to?(:writelines)
    assert ''.respond_to?(:starts_with?)
    assert ''.respond_to?(:truncate)
    assert_equal 16, Integer('10', 16)
  end

  def test_all_extensions_loads_test_unit_assertions

    require 'xqsr3/all_extensions'

    assert self.respond_to?(:assert_true)
    assert self.respond_to?(:assert_raise_with_message)
  end
end
