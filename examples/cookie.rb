require 'darwinning'

class Cookie < Darwinning::Organism
	@name = "Chocolate Chip Cookie"
	@genes = [
		Darwinning::Gene.new(name: "white sugar", value_range: (0..1), units: "cup"),
		Darwinning::Gene.new(name: "brown sugar", value_range: (0..1), units: "cup"),
		Darwinning::Gene.new(name: "flour", value_range: (0..3), units: "cup"),
		Darwinning::Gene.new(name: "eggs", value_range: (0..3)),
		Darwinning::Gene.new(name: "baking powder", value_range: (0..2), units: "teaspoon"),
		Darwinning::Gene.new(name: "salt", value_range: (0..2), units: "teaspoon"),
		Darwinning::Gene.new(name: "butter", value_range: (0..2), units: "cup"),
		Darwinning::Gene.new(name: "vanilla extract", value_range: (0..2), units: "teaspoon"),
		Darwinning::Gene.new(name: "chocolate chips", value_range: (0..20), units: "ounce"),
		Darwinning::Gene.new(name: "oven temp", value_range: (300..400), units: "degrees F"),
		Darwinning::Gene.new(name: "cook time", value_range: (5..20), units: "minute")
	]
end

# Create a population of 10 Cookies (cookie recipes to be more accurate)
# with a goal of getting a cookie with a rating of 5 (or the highest rating after 100 generations)
# with a mutation rate of 0.1
# and taking member fitness as a manually entered value each generation
p = Darwinning::Population.new(
	organism: Cookie, population_size: 10,
	fitness_goal: 5, generations_limit: 100
)

puts "First Generation of Cookie Population"
p.members.each { |m| m.nice_print }  # print the initial population members

# We manually gather 5 star ratings for all 10 cookie recipes and store them in an array
first_gen_ratings = [1.5, 4, 3, 3.5, 2, 1, 1.5, 3, 2.5, 0.5]

# Then assign each member a fitness value
p.set_members_fitness!(first_gen_ratings)

p.make_next_generation!

puts "Second Generation of Cookie Population"
p.members.each { |m| m.nice_print } # note, all new members will again have a fitness of -1 until manually set
