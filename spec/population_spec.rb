require 'spec_helper'

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
