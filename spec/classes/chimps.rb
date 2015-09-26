class GenelessChimp
  include Darwinning
end

class BadGenesChimp
  include Darwinning

  GENE_RANGES = "throw poop?"
end

class EmptyGenesChimp
  include Darwinning

  GENE_RANGES = {}
end

class NoValuesChimp
  include Darwinning

  GENE_RANGES = {
    throwing_range: (0..100)
  }
end