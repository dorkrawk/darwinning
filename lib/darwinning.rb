require 'darwinning/gene'

module Darwinning

	class Population
		att_accessor :members, :mutation_rate, :generations_limit, :fitness_goal

		members = []
		mutation_rate = 0.0
		generations_limit = 0
		fitness_goal = 0
		organism = ""

		def initialize(organism, population_size, fitness_goal, mutation_rate = 0.0, generations_limit = 0)
			build_population
		end

		def build_population
			population_size.times do |i|
				members << organism.new 
			end
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

		def get_best

		end
	end

end