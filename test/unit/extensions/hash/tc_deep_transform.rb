#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/hash/deep_transform'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'


class Test_Hash_deep_transform < Test::Unit::TestCase

  def test_Hash_has_method

    assert Hash.new.respond_to? :deep_transform
  end

  def test_with_empty

    assert_equal Hash.new, Hash.new.deep_transform { |k| k }
    assert_equal Hash.new, Hash.new.deep_transform { |k, v| [ k, v ] }
  end

  def test_transform_to_same

    jkl = 12
    h = { 'abc' => 'def', ghi: jkl, mno: { p: 'q', 'r' => 'st' } }

    assert_equal h, h.deep_transform { |k| k }
    assert_equal h, h.deep_transform { |k, v| [ k, v ] }
  end

  def test_transform_to_symbolise_keys

    jkl = 12
    h = { 'abc' => 'def', ghi: jkl, mno: { p: 'q', 'r' => 'st' } }

    h_1 = { abc: 'def', ghi: jkl, mno: { p: 'q', r: 'st' } }
    h_2 = { abc: :def, ghi: jkl, mno: { p: :q, r: :st } }

    assert_equal h_1, h.deep_transform { |k| k.respond_to?(:to_sym) ? k.to_sym : k }
    assert_equal h_1, h.deep_transform { |k, v| [ k.respond_to?(:to_sym) ? k.to_sym : k, v ] }
    assert_equal h_2, h.deep_transform { |k, v| [ k.respond_to?(:to_sym) ? k.to_sym : k, v.respond_to?(:to_sym) ? v.to_sym : v ] }
  end
end


