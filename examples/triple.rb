require '../lib/darwinning'

class Triple
  extend Darwinning

  GENE_RANGES = {
    first_number: (0..100),
    second_number: (0..100),
    third_number: (0..100)
  }

  attr_accessor :first_number, :second_number, :third_number, :genotypes

  def fitness
    # Try to get the sum of the 3 digits to add up to 100
    (first_number + second_number + third_number - 100).abs
  end
end

if Triple.is_evolveable?

  triple_pop = Triple.build_population(0, 10, 100)
  triple_pop.evolve! # create new generations until fitness goal is met or generation limit is met


  puts "Solution"
  puts "========"
  puts "number of generations: #{triple_pop.history.size}"
  puts triple_pop.best_member # print the member representing the solution
  puts triple_pop.best_member.fitness

end