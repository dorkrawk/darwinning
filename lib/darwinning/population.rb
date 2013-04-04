module Darwinning

	class Population
		attr_accessor :members, :mutation_rate, :generations_limit, :fitness_goal, :organism, :generation

		def initialize(organism, population_size, fitness_goal, mutation_rate = 0.0, generations_limit = 0)
			@organism = organism
			@fitness_goal = fitness_goal
			@mutation_rate = mutation_rate
			@generations_limit = generations_limit
			@members = []
			@generation = 0 # initial population is generation 0
			
			build_population(population_size)
		end

		def build_population(population_size)
			population_size.times do |i|
				@members << @organism.new 
			end
		end

		def evolve

		end

		def crossover
			m1 = weighted_select(@members)
			m2 = weighted_select(@members - [m1])
			
		end

		def sexytimes
			crossover
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

			selected_member
		end

		def mutate

		end

		def make_next_generation
			crossover
			mutate
			is_over?
		end

		def evolution_over?
			# check if the fiteness goal or generation limit has been met
			@generation == @generations_limit or best_member.fitness == @fitness_goal
		end

		def get_population

		end

		def best_member
			@members.sort_by { |m| m.fitness }[0]
		end

		def size
			@members.length
		end
	end
end