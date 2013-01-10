module Darwinning

	class Population
		att_accessor :members, :mutation_rate, :generations_limit, :fitness_goal

		def initialize(organism, population_size, fitness_goal, mutation_rate = 0.0, generations_limit = 0)

		end
	end

	# maybe this doesn't need to exist
	class Evolution
		population = []
		mutation_rate = 0.0
		generations_limit = 0
		fitness_goal = 0

		def build_population

		end

		def crossover

		end

		def sexytimes
			crossover
		end
			
		end

		def mutate

		end

		def make_next_generation
			crossover
			mutate
			is_over?
		end

		def is_over?
			# check if the fiteness goal or generation limit has been met
		end

		def get_population

		end

		def get_current_best

		end
	end

	class Organism
		# parent class for user organisms
		genes = []  # class variables
		genotypes = [Gene,Gene] # instance variables

		def fitness
			0
		end
	end

	class Gene
		# builds organisms

		# TODO: maybe make gene types based on primitive types, include 'whitelist' and 'blacklist' rather than just invalid_values

		att_accessor :name, :value, :min_value, :max_value, :invalid_values

		def initialize(name = "", value = nil, min_value = nil, max_value = nil, invalid_values = [])
			@name = name
			@value = value
			@min_value = min_value
			@max_value = max_value
			@invalid_values = invalid_values
		end
	end


end