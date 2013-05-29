Darwinning
==========
[![Gem Version](https://badge.fury.io/rb/darwinning.png)](http://badge.fury.io/rb/darwinning)

[gem]: https://rubygems.org/gems/darwinning

A Ruby gem to aid in the use of genetic algorithms.

Installation
--------

```
gem install darwinning
```

Examples
--------

### Fifteen

Here's an dumb example of how you might use Darwinning to solve a pointless problem:

Let's say for some reason you need a set of 3 number that add up to 15.  This is a strange problem to have, but let's solve it anyway.

```ruby
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

p = Darwinning::Population.new(Triple, 10, 0, 0.1, 100)
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

p = Darwinning::Population.new(Cookie, 10, 5, 0.1, 100, true)

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