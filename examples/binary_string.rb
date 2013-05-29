require '../lib/darwinning'

class BinaryOrganism < Darwinning::Organism
	size = 10
	size.times { |s| @genes << Darwinning::Gene.new("", [0,1]) }

	def fitness
		(genotypes.inject{ |sum, x| sum + x } - 9).abs
	end  
end

# Build a population of binary strings 10 digits long
p = Darwinning::Population.new(BinaryOrganism, 20, 0, 0.1, 100)

puts "First Generation of Population!"
p.members.each { |m| m.nice_print }

p.evolve!

puts "Solution:"
p.best_member.nice_print # print the member representing the solution

puts "Solution met after #{p.generation} generations."
