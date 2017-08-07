#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/xml/utilities/compare'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_Xqsr3_XML_Utilities_Compare < Test::Unit::TestCase

	include ::Xqsr3::XML::Utilities::Compare

	def test_compare_nil

		assert xml_compare(nil, nil).same?

		assert_false xml_compare('', nil).same?
		assert_false xml_compare(nil, '').same?

		assert xml_compare('', nil, equate_nil_and_empty: true).same?
		assert xml_compare(nil, '', equate_nil_and_empty: true).same?
	end

	def test_compare_empty

		assert xml_compare('', '').same?

		assert_false xml_compare('<abc/>', '').same?
		assert_false xml_compare('', '<abc/>').same?
	end

	def test_compare_one_level_1

		assert xml_compare('<abc/>', '<abc/>').same?
		assert xml_compare('<abc/>', '<abc></abc>').same?
		assert_false xml_compare('<abc/>', '<def/>').same?
	end

	def test_compare_two_level_1

		assert xml_compare('<parent><child1></child1></parent>', '<parent><child1></child1></parent>').same?
		assert xml_compare('<parent><child1/></parent>', '<parent><child1></child1></parent>').same?

		r = xml_compare('<parent><child1/></parent>', '<parent><child2/></parent>')

		assert_false r.same?
	end

	def test_compare_attributes_1

		lhs		=	<<END_OF_lhs
<node name="John Smith" age="21" />
END_OF_lhs

		rhs_same	=	<<END_OF_lhs
<node age="21" name="John Smith" />
END_OF_lhs

		rhs_diff	=	<<END_OF_lhs
<node name="John Smith" age="22" />
END_OF_lhs

		r			=	xml_compare lhs, rhs_same, ignore_attribute_order: false

		assert r.different?, r.details
		assert_equal :different_attribute_order, r.reason

		r			=	xml_compare lhs, rhs_same, ignore_attribute_order: true

		assert r.same?

		r			=	xml_compare lhs, rhs_same, element_order: false

		assert r.same?

		r			=	xml_compare lhs, rhs_diff

		assert r.different?
		assert_equal :different_attributes, r.reason
	end

	def test_compare_two_level_2

		lhs		=	<<END_OF_lhs
<parent>
 <child1/>
</parent>
END_OF_lhs
		rhs		=	<<END_OF_rhs
<parent>
 <child1>
 </child1>
</parent>
END_OF_rhs

		r		=	xml_compare lhs, rhs, normalize_whitespace: false

		assert r.different?, "#{r.details}"
		assert_equal :different_node_contents, r.reason

		r		=	xml_compare(lhs, rhs, normalize_whitespace: true)

		assert r.same?, "#{r.details}"
	end

	def test_compare_two_level_3

		lhs		=	<<END_OF_lhs
<parent>
 <child1/>
 <child2>
  <grandchild2a/>
 </child2>
</parent>
END_OF_lhs
		rhs		=	<<END_OF_rhs
<parent>
 <child2><grandchild2a/></child2>
 <child1>
 </child1>
</parent>
END_OF_rhs

		r		=	xml_compare lhs, rhs, normalize_whitespace: true

		assert r.same?, "#{r.details}"
	end

end

