module Darwinning
  module EvolutionTypes

    class Mutation
      attr_reader :mutation_rate

      def initialize(options = {})
        @mutation_rate = options.fetch(:mutation_rate, 0.0)
      end

      def evolve(members)
        mutate(members)
      end

      def pairwise?
        false
      end

      protected

      def mutate(members)
        members.map do |member|
          if (0..100).to_a.sample < mutation_rate * 100
            re_express_random_genotype(member)
          else
            member
          end
        end
      end

      # Selects a random genotype from the organism and re-expresses its gene
      def re_express_random_genotype(member)
        random_index = (0..member.genotypes.length - 1).to_a.sample
        new_gene = member.genes[random_index].express
        member.genotypes[random_index] = member.genes[random_index].express
        member
      end
    end

  end
end
