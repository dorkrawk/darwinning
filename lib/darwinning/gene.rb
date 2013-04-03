
	class Gene
		# builds organisms

		# TODO: maybe make gene types based on primitive types, include 'whitelist' and 'blacklist' rather than just invalid_values

		attr_accessor :name, :value, :min_value, :max_value, :invalid_values

		def initialize(name = "", min_value = nil, max_value = nil, invalid_values = [])
			@name = name
			@min_value = min_value
			@max_value = max_value
			@invalid_values = invalid_values

			@value = nil
		end

		def express
			@value = ((@min_value..@max_value).to_a - invalid_values).sample
		end
	end