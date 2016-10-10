require 'spec_helper'

describe Darwinning::Population do
  let(:pop_triple) {
    Darwinning::Population.new(
      organism: Triple, population_size: 10, fitness_goal: 0
    )
  }

  it "fitness goal should be set to 0" do
    expect(pop_triple.fitness_goal).to eq 0
  end

  it "population size should be 10" do
    expect(pop_triple.members.length).to eq 10
  end

  it "population should start on generation 0" do
    expect(pop_triple.generation).to eq 0
  end

  it "make_next_generation! should evolve population by one generation" do
    old_members = pop_triple.members
    pop_triple.make_next_generation!

    expect(pop_triple.generation).to eq 1
    expect(pop_triple.members).not_to eq old_members
  end

  describe "#make_next_generation!" do
    context "with a specified odd-number for population size" do
      it "does not change the member count" do
        population = Darwinning::Population.new(
          organism: Triple, fitness_goal: 0, population_size: 3
        )

        expect { population.make_next_generation! }.not_to change{ population.members.length }
      end
    end

    context "with a specified not-positive number for population size" do
      it "raises an exception" do
        population = Darwinning::Population.new(
          organism: Triple, fitness_goal: 0, population_size: 0
        )

        expect { population.make_next_generation! }.to raise_error(RuntimeError)
      end
    end
  end

  describe "#history" do

    it "should be generations + 1 in size" do
      pop_triple.evolve!
      expect(pop_triple.history.size).to eq pop_triple.generation + 1
    end

  end

end
