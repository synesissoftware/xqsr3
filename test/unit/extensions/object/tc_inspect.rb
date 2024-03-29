#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/diagnostics/inspect_builder'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_X_Object_inspect < Test::Unit::TestCase

  class Example1

    include ::Xqsr3::Diagnostics::InspectBuilder

    def initialize **inspect_options

      @alphabet         = 'abcdefghijklmnopqrstuvwxyz'
      @letters          = @alphabet.chars.map { |c| c.upcase }
      @inspect_options  = inspect_options
    end

    def inspect

      make_inspect **@inspect_options
    end
  end

  class ExampleWithHiddenFields < Example1

    INSPECT_HIDDEN_FIELDS = [ 'letters' ]
  end

  def test_default_use

    ex = Example1.new

    assert_match /\A#<Test_X_Object_inspect::Example1:0x\d+>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new

    assert_match /\A#<Test_X_Object_inspect::ExampleWithHiddenFields:0x\d+>\z/, ex2.inspect
  end

  def test_no_class

    ex = Example1.new(no_class: true)

    assert_match /\A#<0x\d+>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new(no_class: true)

    assert_match /\A#<0x\d+>\z/, ex2.inspect
  end

  def test_no_object_id

    ex = Example1.new(no_object_id: true)

    assert_match /\A#<Test_X_Object_inspect::Example1>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new(no_object_id: true)

    assert_match /\A#<Test_X_Object_inspect::ExampleWithHiddenFields>\z/, ex2.inspect
  end

  def test_show_fields

    ex = Example1.new(show_fields: true)

    assert_match /\A#<Test_X_Object_inspect::Example1:0x\d+:\s*@alphabet\(String\)='abcdefghijklmnopqrstuvwxyz';\s*@inspect_options.*;\s*@letters.*>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new(show_fields: true)

    assert_match /\A#<Test_X_Object_inspect::ExampleWithHiddenFields:0x\d+:\s*@alphabet\(String\)='abcdefghijklmnopqrstuvwxyz';\s*@inspect_options\(.+\)=[^;]+>\z/, ex2.inspect
  end

  def test_show_fields_hidden

    ex = Example1.new(show_fields: true, hidden_fields: [ 'inspect_options' ])

    assert_match /\A#<Test_X_Object_inspect::Example1:0x\d+:\s*@alphabet\(String\)='abcdefghijklmnopqrstuvwxyz';\s*@letters.*>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new(show_fields: true, hidden_fields: [ 'inspect_options' ])

    assert_match /\A#<Test_X_Object_inspect::ExampleWithHiddenFields:0x\d+:\s*@alphabet\(String\)='abcdefghijklmnopqrstuvwxyz'>\z/, ex2.inspect
  end

  def test_show_fields_truncated

    ex = Example1.new(show_fields: true, truncate_width: 10)

    assert_match /\A#<Test_X_Object_inspect::Example1:0x\d+:\s*@alphabet\(String\)='abcdefg...';\s*@inspect_options.*;\s*@letters.*>\z/, ex.inspect

    ex2 = ExampleWithHiddenFields.new(show_fields: true, truncate_width: 10)

    assert_match /\A#<Test_X_Object_inspect::ExampleWithHiddenFields:0x\d+:\s*@alphabet\(String\)='abcdefg...';\s*@inspect_options.*>\z/, ex2.inspect
  end
end

