module Darwinning

  class Gene
    attr_reader :name, :value_range, :invalid_values, :units, :value

    def initialize(options = {})
      @name = options.fetch(:name, '')
      @value_range = Array(options.fetch(:value_range, []))
      @invalid_values = Array(options.fetch(:invalid_values, []))
      @units = options.fetch(:units, '')
    end

    def express
      if rand(value_range).is_a? Float
        # Float value ranges can't have invalid values
        rand(value_range)
      else
        (value_range - invalid_values).sample
      end
    end

    def is_valid_value?(value)
      value_range.include?(value) && !invalid_values.include?(value)
    end
  end

end
