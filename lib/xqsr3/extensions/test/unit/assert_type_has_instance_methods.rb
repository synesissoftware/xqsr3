
module Test
module Unit

module Assertions

	unless respond_to? :assert_type_has_instance_methods

		# Fails unless the given +type+ responds to all of the messages
		# given by +message_spec+
		#
		# === Signature
		#
		# * *Parameters*
		#   - +type+:: [::Class] The type
		#   - +message_spec+:: [::Symbol, ::Array, ::Hash] A specification
		#     of message(s) received by the instances of +type+. If a
		#     ::Symbol, then instances must respond to this single message.
		#     If an ::Array (all elements of which must be ::Symbol), then
		#     instances must respond to _all_ messages. If a ::Hash, then
		#     instances must respond to _all_ messages represented by the
		#     keys; the values are available for specifying a custom failure
		#     message (or value is +nil+ for stock message)
		#  - +failure_message+:: [::String] If specified, is used when
		#     instances of +type+ do not respond to a message and no custom
		#     failure message is provided for it
		def assert_type_has_instance_methods(type, message_spec, failure_message = nil)

			warn "type parameter - '#{type} (#{type.class})' - should be a Class" unless type.is_a?(::Class)

			case message_spec
			when ::Hash

				warn "every key in a Hash message_spec should be of type Symbol" unless message_spec.keys.all? { |k| ::Symbol === k }
			when ::Array

				warn "every key in an Array message_spec should be of type Symbol" unless message_spec.all? { |k| ::Symbol === k }

				message_spec = Hash[message_spec.map { |s| [ s, nil ] }]
			when ::Symbol

				message_spec[message_spec] = nil
			else

				msg = "message_spec - '#{message_spec} (#{message_spec.class})' - should be a Symbol, an Array of Symbols, or a Hash of Symbol => message"

				warn msg

				return assert false, msg
			end

			ims = type.instance_methods

			message_spec.each do |sym, message|

				unless ims.include? sym

					message ||= failure_message
					message	||=	"type #{type} does not contain the instance method #{sym}"

					return assert false, message
				end
			end

			assert true
		end
	end

end # class Assertions
end # module Unit
end # module Test



