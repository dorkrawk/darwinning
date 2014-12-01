module Darwinning
  module EvolutionTypes

    class Reproduction
      def evolve(organism, m1, m2)
        sexytimes(organism, m1, m2)
      end

      def pairwise?
        true
      end

      protected

      def sexytimes(organism, m1, m2)
        genotypes1 = []
        genotypes2 = []

        m1.genotypes.zip(m2.genotypes).each do |g|
          if m1.genotypes.index(g[0]) % 2 == 0
            genotypes1 << g[0]
            genotypes2 << g[1]
          else
            genotypes1 << g[1]
            genotypes2 << g[0]
          end
        end

        [organism.new(genotypes1), organism.new(genotypes2)]
      end
    end

  end
end
