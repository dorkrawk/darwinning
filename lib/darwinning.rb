module Darwinning
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
		@genes = []  # class variables
		genotypes = [Gene,Gene] # instance variables

		def fitness
			0
		end
	end

	class Gene
		# builds organisms
		name = ""
		value = nil
		min = nil
		max = nil
		invalid_values = []
	end


end