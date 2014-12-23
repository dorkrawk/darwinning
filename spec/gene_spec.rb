require 'spec_helper'

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