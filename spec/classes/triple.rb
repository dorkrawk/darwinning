class Triple < Darwinning::Organism
  @name = "Triple"
  @genes = [
    Darwinning::Gene.new(name: "first digit", value_range: (0..9)),
    Darwinning::Gene.new(name: "second digit", value_range: (0..9)),
    Darwinning::Gene.new(name: "third digit", value_range: (0..9))
  ]

  def fitness
    # Try to get the sum of the 3 digits to add up to 15
    (genotypes.values.inject{ |sum, x| sum + x } - 15).abs
  end
end
