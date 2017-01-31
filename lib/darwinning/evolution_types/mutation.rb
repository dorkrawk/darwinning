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
          if rand < mutation_rate
            re_express_random_genotype(member)
          else
            member
          end
        end
      end

      # Selects a random genotype from the organism and re-expresses its gene
      def re_express_random_genotype(member)
        random_index = rand(member.genotypes.length - 1)
        gene = member.genes[random_index]

        if member.class.superclass == Darwinning::Organism
          member.genotypes[gene] = gene.express
        else
          member.send("#{gene.name}=", gene.express)
        end

        member
      end
    end

  end
end
