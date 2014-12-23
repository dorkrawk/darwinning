require 'spec_helper'

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