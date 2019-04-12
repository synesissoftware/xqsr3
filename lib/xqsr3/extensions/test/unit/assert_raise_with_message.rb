
require 'xqsr3/internal_/test_unit_version_'

module Xqsr3
module Internal_ # :nodoc:
module X_assert_raise_with_message_ # :nodoc:

	if TestUnitVersion_.is_at_least? [ 3, 0, 8 ]

		AssertionFailedError_	=	Test::Unit::AssertionFailedError # :nodoc:
	else

		class AssertionFailedError_	< ArgumentError; end # :nodoc:
	end

end # module X_assert_raise_with_message_
end # module Internal_
end # module Xqsr3

module Test
module Unit

module Assertions

	undef :assert_raise_with_message if respond_to? :assert_raise_with_message

	# Asserts that the attached block raises an exception of one of the
	# exceptions defined by +type_spec+ and/or has a message matching
	# +message_spec+
	def assert_raise_with_message(type_spec, message_spec, failure_message = nil, &block)

		unless block_given?

			msg = "WARNING: no block_given to assert_raise_with_message() called from: #{caller[0]}"

			warn "\n#{msg}"

			assert false, msg
		end

		case type_spec
		when ::Array, nil

			;
		else

			type_spec = [ type_spec ]
		end

		case message_spec
		when ::Array, nil

			;
		else

			message_spec = [ message_spec ]
		end


		begin

			yield

			assert false, 'the block did not throw an exception as was expected'
		rescue ::Xqsr3::Internal_::X_assert_raise_with_message_::AssertionFailedError_

			raise
		rescue Exception => x

			if type_spec

				assert false, "exception (#{x.class}) - message: '#{x.message}' - not of any of required types (#{type_spec.join(', ')}); #{x.class} given" unless type_spec.any? { |c| x.is_a? c}
			end

			if message_spec

				assert false, "exception message not of any of required messages; '#{x.message}' given" unless message_spec.any? do |m|

					case m
					when ::Regexp

						x.message =~ m
					when ::String

						x.message == m
					else

						warn "\nunsupported message_spec entry '#{m}' (#{m.class})"
					end
				end
			end

			assert true
		end
	end
end # class Assertions
end # module Unit
end # module Test


