module Darwinning
	class Gene
		attr_accessor :name, :value, :value_range, :invalid_values

		def initialize(name = "", value_range = [], invalid_values = [])
			@name = name
			@value_range = value_range.to_a
			@invalid_values = invalid_values

			@value = nil
		end

		def express
			@value = ((@value_range - @invalid_values).sample
		end
	end
end