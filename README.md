Darwinning
==========
[![Gem Version](https://badge.fury.io/rb/darwinning.svg)](http://badge.fury.io/rb/darwinning)

[gem]: https://rubygems.org/gems/darwinning

A Ruby gem to aid in the use of genetic algorithms.

Installation
--------

```
gem install darwinning
```

Examples
--------

*(to run the included examples, make sure you've installed the gem first)*

### Fifteen

Here's an dumb example of how you might use Darwinning to solve a pointless problem:

Let's say for some reason you need a set of 3 number that add up to 15.  This is a strange problem to have, but let's solve it anyway.

```ruby
class Triple < Darwinning::Organism

	@name = "Triple"
	@genes = [
			Darwinning::Gene.new(name: "first digit", value_range: (0..9)),
			Darwinning::Gene.new(name: "second digit", value_range: (0..9)),
			Darwinning::Gene.new(name: "third digit", value_range: (0..9))
		]

	def fitness
		# Try to get the sum of the 3 digits to add up to 15
		(genotypes.inject{ |sum, x| sum + x } - 15).abs
	end
end 

p = Darwinning::Population.new(
	organism: Triple, population_size: 10,
	fitness_goal: 0, generations_limit: 100
)
p.evolve!

p.best_member.nice_print # prints the member representing the solution
```

This code declares an organism class that inherits from Darwinning's Organism parent class to represent solutions.  Then we create a population of these solution organisms and evolve the population until a solution meets the fitness threshold or the generation limit is met.

### Cookies

Or let's say you want to find the perfect chocolate chip cookie recipie.  Sure you could ask your grandmother, but why not let a genetic algorithm do all the work for you?  Some baking may be required for this one.

Define a cookie Organism class, generate an initial population, bake a batch of each and have your friends rate each batch.  Use that rating as the fitness value for each recipie and then generate the next generation of cookie recipies.  Repeat until you have optimized the recipie or you are sick from eating too many cookies.

```ruby
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

p = Darwinning::Population.new(
	organism: Cookie, population_size: 10,
	fitness_goal: 5, generations_limit: 100
)

first_gen_ratings = [1.5, 4, 3, 3.5, 2, 1, 1.5, 3, 2.5, 0.5]
p.set_members_fitness!(first_gen_ratings)

p.make_next_generation!

p.members.each { |m| m.nice_print } # print second generation of cookie recipies
```

### Binary String Organism

A simple binary string representation of an organism can be easily created thusly:

```ruby
class BinaryOrganism < Darwinning::Organism

	10.times { |s| @genes << Darwinning::Gene.new("", [0,1]) }

	def fitness
		# whatever makes sense here
	end  
end
```

## Built by:
* [Dave Schwantes](https://github.com/dorkrawk "dorkrawk")

### With help from:
* [Cameron Dutro](https://github.com/camertron "camertron")
* [Maurizio Del Corno](https://github.com/druzn3k "druzn3k")