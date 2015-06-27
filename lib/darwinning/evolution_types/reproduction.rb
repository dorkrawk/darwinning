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
        new_genotypes = alternating_swap(m1, m2)

        [organism.new(new_genotypes.first), organism.new(new_genotypes.last)]
      end

      def alternating_swap(m1, m2)
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

        [genotypes1, genotypes2]
      end

      def random_swap(m1, m2)
        genotypes1 = []
        genotypes2 = []

        m1.genotypes.zip(m2.genotypes).each do |g|
          g1_parent = [0,1].sample
          g2_parent = [0,1].sample

          genotypes1 << g[g1_parent]
          genotypes2 << g[g2_parent]
        end

        [genotypes1, genotypes2]
      end
    end
  end
end
