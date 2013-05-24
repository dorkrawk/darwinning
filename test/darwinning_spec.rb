require 'darwinning'

describe Darwinning::Gene do
  before do
    @digit = Darwinning::Gene.new("digit", (0..9))
    @day_hour = Darwinning::Gene.new("hour", (0..23), [0,1,2,3,4,20,21,22,23], "o'clock")
  end

  it "name should be set" do
    @digit.name.should == "digit"
  end

  it "value range should be set" do
    @digit.value_range.should == (0..9).to_a
  end

  it "invalid values should be set" do
    @day_hour.invalid_values.should == [0,1,2,3,4,20,21,22,23]
  end

  it "units should be set" do
    @day_hour.units.should == "o'clock"
  end

  describe "#express" do

    it "expressed value should be within range" do
      (0..9).to_a.include?(@digit.express).should == true  # uncertain test
    end

    it "expressed value should not be invalid value" do
      @day_hour.invalid_values.include?(@digit.express).should == false # uncertain test
    end
  end

end

describe Darwinning::Organism do
  before do
    @org = Darwinning::Organism.new

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

end