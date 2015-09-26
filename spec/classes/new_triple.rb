class NewTriple
  include Darwinning

  GENE_RANGES = {
    first_digit: (0..9),
    second_digit: (0..9),
    third_digit: (0..9)
  }

  attr_accessor :first_digit, :second_digit, :third_digit

  def fitness
    # Try to get the sum of the 3 digits to add up to 15
    (first_digit + second_digit + third_digit - 15).abs
  end
end