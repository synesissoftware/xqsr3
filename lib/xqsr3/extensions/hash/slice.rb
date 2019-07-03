
unless Hash.instance_methods.include? :slice

	class Hash

		def slice(*args)

			r = {}

			args.each do |arg|

				if self.has_key? arg

					r[arg] = self[arg]
				end
			end

			r
		end
	end
end

