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

p = Darwinning::Population.new(Cookie, 10, 0, 0.1, 100, true)