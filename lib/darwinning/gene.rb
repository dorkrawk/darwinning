module Darwinning
	class Gene
		attr_accessor :name, :value, :value_range, :invalid_values, :units

		def initialize(name = "", value_range = [], invalid_values = [], units = "")
			
			@name = name
			@value_range = value_range.to_a
			@invalid_values = invalid_values
			@units = units
		end

		def express
			(@value_range - @invalid_values).sample
		end
	end
end