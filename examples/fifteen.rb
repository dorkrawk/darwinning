require '../lib/darwinning/gene'
require '../lib/darwinning/organism'

class Triple < Organism
	@genes = []
	@genes << Gene.new("first digit", 0, 9, [])
	@genes << Gene.new("second digit", 0, 9, [])
	@genes << Gene.new("third digit", 0, 9, [])

	def fitness
		# Try to get the sum of the 3 digits to add up to 15
		(genes.inject{ |sum, x| sum + x.value } - 15).abs
	end
end 


g = Gene.new("first digit", 0, 9, [])

#puts g.name
#puts g.express

puts Triple.genes.map { |x| x.name }

t = Triple.new
puts t.genotypes


# create a population of 20 Triples
# with a goal of getting a fitness value of 0,
# a mutation rate of 0.1
# and a generation limit of 100
#population = new Population(Triple, 20, 0, 0.1, 100)

# should return the organism that met the fitness value or an error
#population.evolve 

#population2 = new Population(Triple, 20, 0, 0.1, 100)

# show first generation of population
#puts population2.members

#population2.make_next_generation

# show second generation of population
#puts population2.members
#puts population2.get_current_best
