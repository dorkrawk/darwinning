require '../lib/darwinning'

class Triple
  extend Darwinning

  GENE_RANGES = {
    first_digit: (0..9),
    second_digit: (0..9),
    third_digit: (0..9)
  }

  attr_accessor :first_digit, :second_digit, :third_digit

  def fitness
    # Try to get the sum of the 3 digits to add up to 15
    (first_digit + second_digit + third_digit - 15).abs
  end
end

triple_pop = Triple.build_population(population_size: 10, fitness_goal: 0, generations_limit: 100)
triple_pop.evolve! # create new generations until fitness goal is met or generation limit is met

puts "Solution:"
puts triple_pop.best_member # print the member representing the solution
puts triple_pop.best_member.fitness