module Darwinning

  class Population
    attr_accessor :members, :mutation_rate, :generations_limit, :fitness_goal, :organism, :generation

    def initialize(organism, population_size, fitness_goal, mutation_rate = 0.0, generations_limit = 0, manual_fitness = false)
      @organism = organism
      @fitness_goal = fitness_goal
      @mutation_rate = mutation_rate
      @generations_limit = generations_limit
      @manual_fitness = manual_fitness
      @members = []
      @generation = 0 # initial population is generation 0

      build_population(population_size)
    end

    def build_population(population_size)
      population_size.times do |i|
        @members << @organism.new
      end
    end

    def evolve!
      until evolution_over?
        make_next_generation!
      end
    end

    def crossover(m1, m2)
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

      [@organism.new(genotypes1), @organism.new(genotypes2)]
    end

    def sexytimes(m1, m2)
      crossover(m1, m2)
    end

    def weighted_select(members)
      e = 0.01
      fitness_sum = members.inject(0) { |sum, m| sum + m.fitness }

      weighted_members = members.sort_by { |m| (m.fitness - @fitness_goal).abs }.map { |m| [m, fitness_sum / ((m.fitness - @fitness_goal).abs + e)] }

      weight_sum = weighted_members.inject(0) { |sum, m| sum + m[1] }
      pick = (0..weight_sum).to_a.sample

      weighted_members.reverse! # In order to pop from the end we need the lowest ranked first
      pick_sum = 0

      until pick_sum > pick do
        selected_member = weighted_members.pop
        pick_sum += selected_member[1]
      end

      selected_member[0]
    end

    def mutate!
      @members.map! { |m|
        if (0..100).to_a.sample < @mutation_rate*100
          m.mutate!
        else
          m
        end
      }
    end

    def set_members_fitness!(fitness_values)
      @members.to_enum.each_with_index { |m, i| m.fitness = fitness_values[i] }
    end

    def make_next_generation!
      temp_members = @members
      used_members = []
      new_members = []

      until new_members.length == @members.length/2
        m1 = weighted_select(@members - used_members)
        used_members << m1
        m2 = weighted_select(@members - used_members)
        used_members << m2

        new_members << crossover(m1,m2)
      end

      new_members.flatten!

      @members = new_members

      mutate!
      @generation += 1
    end

    def evolution_over?
      # check if the fiteness goal or generation limit has been met
      @generation == @generations_limit or best_member.fitness == @fitness_goal
    end

    def best_member
      @members.sort_by { |m| m.fitness }[0]
    end

    def size
      @members.length
    end
  end
end