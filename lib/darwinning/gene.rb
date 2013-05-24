module Darwinning
  class Gene
    attr_accessor :name, :value, :value_range, :invalid_values, :units

    def initialize(name = "", value_range = [], invalid_values = [], units = "")

      @name = name
      @value_range = value_range.to_a
      @invalid_values = invalid_values.to_a
      @units = units
    end

    def express
      (@value_range - @invalid_values).sample
    end

    def is_valid_value?(value)
      @value_range.include?(value) and not @invalid_values.include?(value)
    end
  end
end