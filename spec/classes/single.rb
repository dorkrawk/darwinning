class Single < Darwinning::Organism
  @name = "Single"
  @genes = [
    Darwinning::Gene.new(name: "first digit", value_range: (0..9))
  ]

  def fitness
    # Try to get the digit to equal 15
    (genotypes.values.inject{ |sum, x| sum + x } - 15).abs
  end
end
