# frozen_string_literal: true

unless Hash.instance_methods.include? :slice

  # Standard Ruby Hash extended with #slice when unavailable.
  class Hash

    # Returns a new hash containing only the requested existing keys.
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

