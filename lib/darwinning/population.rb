module Darwinning
  class Population

    EPSILON = 0.01

    attr_reader :members, :generations_limit, :fitness_goal,
                :organism, :population_size, :generation,
                :evolution_types, :history

    DEFAULT_EVOLUTION_TYPES = [
      Darwinning::EvolutionTypes::Reproduction.new(crossover_method: :alternating_swap),
      Darwinning::EvolutionTypes::Mutation.new(mutation_rate: 0.10)
    ]

    def initialize(options = {})
      @organism = options.fetch(:organism)
      @population_size = options.fetch(:population_size)
      @fitness_goal = options.fetch(:fitness_goal)
      @generations_limit = options.fetch(:generations_limit, 0)
      @evolution_types = options.fetch(:evolution_types, DEFAULT_EVOLUTION_TYPES)
      @members = []
      @generation = 0 # initial population is generation 0
      @history = []

      build_population(@population_size)
      @history << @members
    end

    def build_population(population_size)
      population_size.times do |i|
        @members << build_member
      end
    end

    def evolve!
      until evolution_over?
        make_next_generation!
      end
    end

    def set_members_fitness!(fitness_values)
      throw "Invaid number of fitness values for population size" if fitness_values.size != members.size
      members.to_enum.each_with_index { |m, i| m.fitness = fitness_values[i] }
    end

    def make_next_generation!
      temp_members = members
      new_members = []

      until new_members.length == members.length
        m1 = weighted_select(members)
        m2 = weighted_select(members)

        new_members += apply_pairwise_evolutions(m1, m2)
      end

      @members = apply_non_pairwise_evolutions(new_members)
      @history << @members
      @generation += 1
    end

    def evolution_over?
      # check if the fitness goal or generation limit has been met
      if generations_limit > 0
        generation == generations_limit || best_member.fitness == fitness_goal
      else
        best_member.fitness == fitness_goal
      end
    end

    def best_member
      @members.sort_by { |m| m.fitness }.first
    end

    def size
      @members.length
    end

    def organism_klass
      real_organism = @organism
      fitness_function = @fitness_function
      klass = Class.new(Darwinning::Organism) do
        @name = real_organism.name
        @genes = real_organism.genes
      end
    end

    private

    def build_member
      member = organism.new
      unless member.class.superclass.to_s == "Darwinning::Organism"
        member.class.genes.each do |gene|
          gene_expression = gene.express
          member.send("#{gene.name}=", gene_expression)
        end
      end
      member
    end

    def weighted_select(members)
      fitness_sum = members.inject(0) { |sum, m| sum + m.fitness }

      weighted_members = members.sort_by do |m|
        (m.fitness - fitness_goal).abs
      end.map do |m|
        [m, fitness_sum / ((m.fitness - fitness_goal).abs + EPSILON)]
      end

      weight_sum = weighted_members.inject(0) { |sum, m| sum + m[1] }
      pick = (0..weight_sum).to_a.sample

      weighted_members.reverse! # In order to pop from the end we need the lowest ranked first
      pick_sum = 0

      until pick_sum > pick do
        selected_member = weighted_members.pop
        pick_sum += selected_member[1]
      end

      selected_member.first
    end

    def apply_pairwise_evolutions(m1, m2)
      evolution_types.inject([m1, m2]) do |ret, evolution_type|
        if evolution_type.pairwise?
          evolution_type.evolve(*ret)
        else
          ret
        end
      end
    end

    def apply_non_pairwise_evolutions(members)
      evolution_types.inject(members) do |ret, evolution_type|
        if evolution_type.pairwise?
          ret
        else
          evolution_type.evolve(ret)
        end
      end
    end

  end
end
