module Darwinning
  class Population

    attr_reader :members, :generations_limit, :fitness_goal, :fitness_objective,
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
      @fitness_objective = options.fetch(:fitness_objective, :nullify) # :nullify, :maximize, :minimize
      @generations_limit = options.fetch(:generations_limit, 0)
      @evolution_types = options.fetch(:evolution_types, DEFAULT_EVOLUTION_TYPES)
      @members = []
      @generation = 0 # initial population is generation 0
      @history = []

      build_population(@population_size)
      sort_members
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
      sort_members
    end

    def make_next_generation!
      verify_population_size_is_positive!

      new_members = []

      until new_members.length >= members.length
        m1 = weighted_select
        m2 = weighted_select

        new_members += apply_pairwise_evolutions(m1, m2)
      end

      # In the case of an odd population size, we likely added one too many members.
      new_members.pop if new_members.length > members.length

      @members = apply_non_pairwise_evolutions(new_members)
      sort_members
      @history << @members
      @generation += 1
    end

    def evolution_over?
      # check if the fitness goal or generation limit has been met
      if generations_limit > 0
        generation == generations_limit || goal_attained?
      else
        goal_attained?
      end
    end

    def best_member
      @members.first
    end

    def best_each_generation
      @history.map(&:first)
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

    def goal_attained?
      case @fitness_objective
      when :nullify
        best_member.fitness.abs <= fitness_goal
      when :maximize
        best_member.fitness >= fitness_goal
      else
        best_member.fitness <= fitness_goal
      end
    end

    def sort_members
      case @fitness_objective
      when :nullify
        @members = @members.sort_by { |m| m.fitness ? m.fitness.abs : m.fitness }
      when :maximize
        @members = @members.sort_by { |m| m.fitness }.reverse
      else
        @members = @members.sort_by { |m| m.fitness }
      end
    end

    def verify_population_size_is_positive!
      unless @population_size.positive?
        raise "Population size must be a positive number!"
      end
    end

    def build_member
      member = organism.new
      unless member.class < Darwinning::Organism
        member.class.genes.each do |gene|
          gene_expression = gene.express
          member.send("#{gene.name}=", gene_expression)
        end
      end
      member
    end

    def compute_normalized_fitness(membs=members)
      normalized_fitness = nil
      return membs.collect { |m| [1.0/membs.length, m] } if membs.first.fitness == membs.last.fitness
      if @fitness_objective == :nullify
        normalized_fitness = membs.collect { |m| [ m.fitness.abs <= fitness_goal ? Float::INFINITY : 1.0/(m.fitness.abs - fitness_goal), m] }
      else
        if @fitness_objective == :maximize
          if fitness_goal == Float::INFINITY then
            #assume goal to be at twice the maximum distance between fitness
            goal = membs.first.fitness + ( membs.first.fitness - membs.last.fitness )
          else
            goal = fitness_goal
          end
          normalized_fitness  = membs.collect { |m| [ m.fitness >= goal ? Float::INFINITY : 1.0/(goal - m.fitness), m] }
        else
          if fitness_goal == -Float::INFINITY then
            goal = membs.first.fitness - ( membs.last.fitness - membs.first.fitness )
          else
            goal = fitness_goal
          end
          normalized_fitness  = membs.collect { |m| [ m.fitness <= goal ? Float::INFINITY : 1.0/(m.fitness - goal), m] }
        end
      end
      if normalized_fitness.first[0] == Float::INFINITY then
        normalized_fitness.collect! { |m|
          m[0] == Float::INFINITY ? [1.0, m[1]] : [0.0, m[1]]
        }
      end
      sum = normalized_fitness.collect(&:first).inject(0.0, :+)
      normalized_fitness.collect { |m| [m[0]/sum, m[1]] }
    end

    def weighted_select(membs=members)
      normalized_fitness = compute_normalized_fitness
      normalized_cumulative_sums = []
      normalized_cumulative_sums[0] = normalized_fitness[0]
      (1...normalized_fitness.length).each { |i|
        normalized_cumulative_sums[i] = [ normalized_cumulative_sums[i-1][0] + normalized_fitness[i][0], normalized_fitness[i][1] ]
      }

      normalized_cumulative_sums.last[0] = 1.0
      cut = rand
      return normalized_cumulative_sums.find { |e| cut < e[0] }[1]
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
