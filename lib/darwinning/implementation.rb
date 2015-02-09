module Darwinning
  module Implementation
  
    def genes
      gene_ranges.map { |k,v| Gene.new(name: k, value_range: v) }
    end

    def build_population(population_size = 10, generation_limit = 100, fitness_goal)
      Population.new(organism: self, population_size: population_size,
                     generation_limit: generation_limit, fitness_goal: fitness_goal)
    end

    private

    def gene_ranges
      self::GENE_RANGES
    end

    def valid_genes?
      genes.each do |gene|
        return false unless self.method_defined? gene.name
      end
      true
    end
  end
end