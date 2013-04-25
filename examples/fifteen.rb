require '../lib/darwinning'

class Triple < Darwinning::Organism

	@name = "Triple"
	@genes = [
			Darwinning::Gene.new("first digit", (0..9)),
			Darwinning::Gene.new("second digit", (0..9)),
			Darwinning::Gene.new("third digit", (0..9))
		]

	def fitness
		# Try to get the sum of the 3 digits to add up to 15
		(genotypes.inject{ |sum, x| sum + x } - 15).abs
	end
end 

# create a population of 10 Triples
# with a goal of getting a fitness value of 0,
# a mutation rate of 0.1
# and a generation limit of 100
p = Darwinning::Population.new(Triple, 10, 0, 0.5, 100)
#puts p.members.map { |m| m.fitness }
puts "members"
puts p.members
puts ""
#puts p.best_member.genotypes
puts "members in next generation"
p.make_next_generation!
puts p.members

puts "m1: #{p.members[0].genotypes}"
puts "m2: #{p.members[1].genotypes}"

new_ms = p.sexytimes(p.members[0], p.members[1])
puts "new_m1: #{new_ms[0].genotypes}"
puts "new_m2: #{new_ms[1].genotypes}"
puts "mutated_new_m2: #{new_ms[1].mutate!.genotypes}"


# should return the organism that met the fitness value or an error
#population.evolve 

#population2 = new Population(Triple, 20, 0, 0.1, 100)

# show first generation of population
#puts population2.members

#population2.make_next_generation

# show second generation of population
#puts population2.members
#puts population2.get_current_best




# class BinaryString < Darwinning::Organism
# 		def initialize(name, length)
# 			@name = name
# 			@genes = Array.new(length) { Darwinning::Gene.new("bit",0,1) }
# 			super
# 		end
# 	end
