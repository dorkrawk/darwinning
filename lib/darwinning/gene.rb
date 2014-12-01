module Darwinning

  class Gene
    attr_accessor :name, :value, :value_range, :invalid_values, :units

    def initialize(options = {})
      @name = options.fetch(:name, '')
      @value_range = Array(options.fetch(:value_range, []))
      @invalid_values = Array(options.fetch(:invalid_values, []))
      @units = options.fetch(:units, '')
    end

    def express
      (value_range - invalid_values).sample
    end

    def is_valid_value?(value)
      value_range.include?(value) && !invalid_values.include?(value)
    end
  end

end
