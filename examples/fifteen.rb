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
# with a goal of getting a fitness value of 0 (or the closeset after 100 generations),
# a mutation rate of 0.1
# fitness will be calculated by the fitness function provided in the Triple class definition
p1 = Darwinning::Population.new(Triple, 10, 0, 0.1, 100)

puts "First Generation of Population"
p1.members.each { |m| m.nice_print }  # print the initial population members

p1.evolve # create new generations until fitness goal is met or generation limit is met

puts "Solution:"
p1.best_member.nice_print # print the member representing the solution

puts "Solution met after #{p1.generation} generations."

# create a new population of Triples
p2 = Darwinning::Population.new(Triple, 10, 0, 0.1, 100)

puts "Second Generation of p2:"
p2.make_next_generation! # manually create 2nd generation of popuation
p2.members.each { |m| m.nice_print }

puts "Newly Created Members from p2:"
# mannually "breed" 2 population members
new_members = p2.sexytimes(p2.members[0], p2.members[1]) # sexytimes is an alias for crossover, because it's funny
new_members.each { |m| m.nice_print }

puts "Mutated Member from p2"
# mannually mutate one of the newly created organisms
new_members[0].mutate!.nice_print
