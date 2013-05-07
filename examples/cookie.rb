require '../lib/darwinning'

class Cookie < Darwinning::Organism

	@name = "Chocolate Chip Cookie"
	@genes = [
			Darwinning::Gene.new("white sugar", (0..1), [], "cup"),
			Darwinning::Gene.new("brown sugar", (0..1), [], "cup"),
			Darwinning::Gene.new("flour", (0..3), [], "cup"),
			Darwinning::Gene.new("eggs", (0..3)),
			Darwinning::Gene.new("baking powder", (0..2), [], "teaspoon"),
			Darwinning::Gene.new("salt", (0..2), [], "teaspoon"),
			Darwinning::Gene.new("butter", (0..2), [], "cup"),
			Darwinning::Gene.new("vanilla extract", (0..2), [], "teaspoon"),
			Darwinning::Gene.new("chocolate chips", (0..20), [], "ounce"),
			Darwinning::Gene.new("oven temp", (300..400), [], "degrees F"),
			Darwinning::Gene.new("cook time", (5..20), [], "minute")
		]

end

# Create a population of 10 Cookies (cookie recipies to be more accurate)
# with a goal of getting a cookie with a rating of 5 (or the highest rating after 100 generations)
# with a mutation rate of 0.1
# and taking member fitness as a manually entered value each generation
p = Darwinning::Population.new(Cookie, 10, 5, 0.1, 100, true)

puts "First Generation of Cookie Population"
p.members.each { |m| m.nice_print }  # print the initial population members

# We manually gather 5 star ratings for all 10 cookie recipies and store them in an array
first_gen_ratings = [1.5, 4, 3, 3.5, 2, 1, 1.5, 3, 2.5, 0.5]

# Then assign each member a fitness value
p.set_members_fitness!(first_gen_ratings)

p.make_next_generation!

puts "Second Generation of Cookie Population"
p.members.each { |m| m.nice_print } # note, all new members will again have a fitness of -1 until manually set
