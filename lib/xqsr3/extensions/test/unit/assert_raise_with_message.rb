
module Test
module Unit

module Assertions

	unless respond_to? :assert_raise_with_message

		def assert_raise_with_message(type_spec, message_spec, failure_message = nil)

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

				assert false, "expected did not throw an exception"
			rescue Exception => x

				if type_spec

					assert false, "exception not of any of required types (#{type_spec.join(', ')}); #{x.class} given" unless type_spec.any? { |c| x.is_a? c}
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
	end

end # class Assertions
end # module Unit
end # module Test


