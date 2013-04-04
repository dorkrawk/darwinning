module Darwinning

	class Population
		attr_accessor :members, :mutation_rate, :generations_limit, :fitness_goal, :organism

		def initialize(organism, population_size, fitness_goal, mutation_rate = 0.0, generations_limit = 0)
			@organism = organism
			@fitness_goal = fitness_goal
			@mutation_rate = mutation_rate
			@generations_limit = generations_limit
			@members = []
			
			build_population(population_size)
		end

		def build_population(population_size)
			population_size.times do |i|
				@members << @organism.new 
			end
		end

		def size
			@members.length
		end

		# def crossover

		# end

		# def sexytimes
		# 	crossover
		# end
			
		# end

		# def mutate

		# end

		# def make_next_generation
		# 	crossover
		# 	mutate
		# 	is_over?
		# end

		# def is_over?
		# 	# check if the fiteness goal or generation limit has been met
		# end

		# def get_population

		# end

		# def get_best

		# end
	end
end