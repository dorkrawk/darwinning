Gem::Specification.new do |s|
	s.name = 'darwinning'
	s.version = Darwinning::VERSION

	s.authors = ['Dave Schwantes']
	s.email = 'dave.schwantes@gmail.com'
	s.summary = 'A Ruby gem to aid in the use of genetic algorithms.'
	s.description = 'Darwinning provides tools to build genetic algorithm solutions using a Gene, Organism, and Population structure.'
	s.homepage = 'https://github.com/dorkrawk/darwinning'


	s.files = Dir["{lib}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
	s.require_paths = ["lib"]

	s.test_files  = Dir.glob("{test,spec,features}/**/*.rb")
end