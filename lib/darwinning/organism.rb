# Found from http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
module ClassLevelInheritableAttributes
  def self.included(base)
    base.extend(ClassMethods)    
  end
  
  module ClassMethods
    def inheritable_attributes(*args)
      @inheritable_attributes ||= [:inheritable_attributes]
      @inheritable_attributes += args
      args.each do |arg|
        class_eval %(
          class << self; attr_accessor :#{arg} end
        )
      end
      @inheritable_attributes
    end
    
    def inherited(subclass)
      @inheritable_attributes.each do |inheritable_attribute|
        instance_var = "@#{inheritable_attribute}"
        subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
      end
    end
  end
end

module Darwinning
	class Organism

		include ClassLevelInheritableAttributes
		inheritable_attributes :genes, :name
		attr_accessor :genotypes

		@genes = []  # Gene instances
		@name = ""

		def initialize(genotypes = [])
			#TODO: catch errors if genotype.length != @genotypes.lenght
			# catch if genotype[x] is not a valid value for @gene[x]

			if genotypes == []
				# fill genotypes with expressed Genes
				@genotypes = self.class.genes.map { |g| g.express } # Gene expressions
			else
				@genotypes = genotypes
			end
		end

		def fitness
			-1
		end
	end
end