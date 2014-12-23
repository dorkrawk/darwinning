require 'darwinning'
require './spec/classes/triple'

describe Darwinning::Gene do
  before do
    @digit = Darwinning::Gene.new(name: "digit", value_range: (0..9))
    @day_hour = Darwinning::Gene.new(
      name: "hour",
      value_range: (0..23),
      invalid_values: [0, 1, 2, 3, 4, 20, 21, 22, 23],
      units: "o'clock"
    )
  end

  it "name should be set" do
    @digit.name.should == "digit"
  end

  it "value range should be set" do
    @digit.value_range.should == (0..9).to_a
  end

  it "invalid values should be set" do
    @day_hour.invalid_values.should == [0, 1, 2, 3, 4, 20, 21, 22, 23]
  end

  it "units should be set" do
    @day_hour.units.should == "o'clock"
  end
end

describe Darwinning::Organism do
  before do
    @org = Darwinning::Organism.new
    @triple = Triple.new
  end

  it "name should default to blank" do
    @org.name.should == ""
  end

  it "genes should default to empty array" do
    @org.genes.should == []
  end

  it "genotypes should initialize to empty array if genes is empty" do
    @org.genotypes.should == []
  end

  it "fitness should default to -1" do
    @org.fitness.should == -1
  end

  it "child class should set name" do
    @triple.name.should == "Triple"
  end

  it "child class should set genes" do
    @triple.genes.length.should == 3 # not the best test...
  end

  it "child class should initialize genotypes from genes" do
    @triple.genotypes.length.should == 3 # not the best test...
  end

end

describe Darwinning::Population do
  before do
    @pop_triple = Darwinning::Population.new(
      organism: Triple, population_size: 10, fitness_goal: 0
    )
  end

  it "fitness goal should be set to 0" do
    @pop_triple.fitness_goal.should == 0
  end

  it "population size should be 10" do
    @pop_triple.members.length.should == 10
  end

  it "population should start on generation 0" do
    @pop_triple.generation.should == 0
  end

  it "make_next_generation! should evolve population by one generation" do
    old_members = @pop_triple.members
    @pop_triple.make_next_generation!
    @pop_triple.generation.should == 1
    @pop_triple.members.should_not == old_members
  end

  describe "#history" do

    it "should be generations + 1 in size" do
      @pop_triple.evolve!
      expect(@pop_triple.history.size).to eq @pop_triple.generation + 1
    end

  end

end
