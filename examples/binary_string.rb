require 'darwinning'

class BinaryOrganism < Darwinning::Organism
	10.times do |s|
    @genes << Darwinning::Gene.new(
      name: '', value_range: [0, 1]
    )
  end

	def fitness
		(genotypes.values.inject { |sum, x| sum + x } - 9).abs
	end
end

# Build a population of binary strings 10 digits long
p = Darwinning::Population.new(
  organism: BinaryOrganism, population_size: 20,
  fitness_goal: 0, generations_limit: 100
)

puts "First Generation of Population!"
p.members.each { |m| pp m }

p.evolve!

puts "Solution:"
pp p.best_member # print the member representing the solution

puts "Solution met after #{p.generation} generations."
