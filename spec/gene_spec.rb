require 'spec_helper'

describe Darwinning::Gene do
  let(:digit) { Darwinning::Gene.new(name: "digit", value_range: (0..9)) }
  let(:day_hour) {
    Darwinning::Gene.new(
      name: "hour",
      value_range: (0..23),
      invalid_values: [0, 1, 2, 3, 4, 20, 21, 22, 23],
      units: "o'clock"
    )
  }
  
  it "name should be set" do
    expect(digit.name).to eq "digit"
  end

  it "value range should be set" do
    expect(digit.value_range).to eq (0..9).to_a
  end

  it "invalid values should be set" do
    expect(day_hour.invalid_values).to eq [0, 1, 2, 3, 4, 20, 21, 22, 23]
  end

  it "units should be set" do
    expect(day_hour.units).to eq "o'clock"
  end
end