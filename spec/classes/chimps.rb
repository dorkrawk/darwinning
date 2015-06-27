class GenelessChimp
  extend Darwinning
end

class BadGenesChimp
  extend Darwinning

  GENE_RANGES = "throw poop?"
end

class EmptyGenesChimp
  extend Darwinning

  GENE_RANGES = {}
end

class NoValuesChimp
  extend Darwinning

  GENE_RANGES = {
    throwing_range: (0..100)
  }
end