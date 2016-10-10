class NewSingle
  include Darwinning

  GENE_RANGES = {
    first_digit: (0..9)
  }

  attr_accessor :first_digit

  def fitness
    # Try to get the digit to equal 15
    (first_digit - 15).abs
  end
end