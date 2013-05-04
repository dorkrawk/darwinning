Darwinning
==========
A Ruby gem to aid in the use of genetic algorithms.

Examples
--------

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
p.evolve

p.best_member.nice_print # prints the member representing the solution
```

This code declares an organism class that inherits from Darwinning's Organism parent class to represent solutions.  Then we create a population of these solution organisms and evolve the population until a solution meets the fitness threshold or the generation limit is met.

## Built by:
* [Dave Schwantes](https://github.com/dorkrawk "dorkrawk")