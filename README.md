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

Usage
--------

There are two ways of using Darwinning. You can either start with a class that is a subclass of `Darwinning::Organism` or you can include `Darwinning` in an existing class that you would like to make evolveable.

### Include Style:

*This style is useful if you want to take existing objects and use Darwinning on them when needed.*

Here's an dumb example of how you might use Darwinning to solve a pointless problem:

Let's say for some reason you need a set of 3 numbers (within a range of 0-100) that add up to 100.  This is a strange problem to have, but let's solve it anyway.

```ruby
require 'darwinning'

class Triple
  include Darwinning

  GENE_RANGES = {
    first_number: (0..100),
    second_number: (0..100),
    third_number: (0..100)
  }

  attr_accessor :first_number, :second_number, :third_number

  def fitness
    # Try to get the sum of the 3 digits to add up to 100
    (first_number + second_number + third_number - 100).abs
  end
end
```

In order to use Darwinning this way you must:
- `include Darwinning` in your class
- define a `GENE_RANGES` constant with your relivant value names as keys
- define `attr_accessor`s for all your values
- define a `fitness` method

Once you have your organism class that includes Darwinning, you can create a population and evolve it:

```ruby
if Triple.is_evolveable?
  triple_pop = Triple.build_population(0, 10, 100)
  triple_pop.evolve! # evolve until fitness goal is or generations limit is met

  pp "Best member: #{triple_pop.best_member}"
end
```

### Inheritance Style:

*This style is good when you just want to set up some quick objects to only use in Darwinning tasks.*

Let's solve the same dumb problem we looked at before...

```ruby
require 'darwinning'

class Triple < Darwinning::Organism
  @name = "Triple"
  @genes = [
    Darwinning::Gene.new(name: "first digit", value_range: (0..100)),
    Darwinning::Gene.new(name: "second digit", value_range: (0..100)),
    Darwinning::Gene.new(name: "third digit", value_range: (0..100))
  ]

  def fitness
  # Try to get the sum of the 3 digits to add up to 100
    (genotypes.values.inject { |sum, x| sum + x } - 100).abs
  end
end
```

With this `Darwinning::Organism` class, you can now build a population and evolve it:

```ruby
triple_pop = Darwinning::Population.new(
  organism: Triple, population_size: 10,
  fitness_goal: 0, generations_limit: 100
)
triple_pop.evolve!

pp "Best member: #{triple_pop.best_member}"
```

### Stepping Through Generations Manually

```ruby
# pop is a Darwinning::Population of organisms
puts pop.generation
# 0
pop.make_next_generation!
puts pop.generation
# 1

# you can view a history of population's evolion
puts pop.history
# [[gen0_member1, gen0_member2,...], [gen1_member1, gen1_member2,...]]
```

### More Examples

Check out the `/examples` folder for more examples. That seems like a good place to put examples, right?

## Built by:
* [Dave Schwantes](https://github.com/dorkrawk "dorkrawk")

### With help from:
[lots of great contributers](https://github.com/dorkrawk/darwinning/graphs/contributors) and work based on forks from: [Nanosim-LIG](https://github.com/Nanosim-LIG)
