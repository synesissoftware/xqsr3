
unless Hash.instance_methods.include? :except!

  class Hash

    # Removes from the instance any key-value pairs matching the
    # keys specified in +keys_to_delete+
    def except!(*keys_to_delete)

      keys_to_delete.each do |key|

        self.delete key
      end

      self
    end
    end
end

unless Hash.instance_methods.include? :except

  class Hash

    # Obtains a copy of the instance wherein any key-value pairs
    # matching the keys specified in +keys_to_delete+ are removed
    def except(*keys_to_delete)

      self.dup.except!(*keys_to_delete)
    end
  end
end

