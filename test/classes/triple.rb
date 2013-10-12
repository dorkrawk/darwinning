class Triple < Darwinning::Organism
  @name = "Triple"
  @genes = [
    Darwinning::Gene.new("first digit", (0..9)),
    Darwinning::Gene.new("second digit", (0..9)),
    Darwinning::Gene.new("third digit", (0..9))
  ]

  def fitness
    # Try to get the sum of the 3 digits to add up to 15
    (genotypes.inject{ |sum, x| sum + x } - 15).abs
  end
end