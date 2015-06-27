module Darwinning
  module Implementation
  
    def genes
      gene_ranges.map { |k,v| Gene.new(name: k, value_range: v) }
    end

    def build_population(population_size = 10, generation_limit = 100, fitness_goal)
      Population.new(organism: self, population_size: population_size,
                     generation_limit: generation_limit, fitness_goal: fitness_goal)
    end

    def is_evolveable?
      has_gene_ranges? &&
      gene_ranges.is_a?(Hash) &&
      gene_ranges.any? &&
      valid_genes? &&
      has_fitness_method?
    end

    private

    def has_gene_ranges?
      self.constants.include?(:GENE_RANGES)
    end

    def has_fitness_method?
      self.instance_methods.include?(:fitness)
    end

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