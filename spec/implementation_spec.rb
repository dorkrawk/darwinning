require 'spec_helper'

class NewTriple
  extend Darwinning

  GENE_RANGES = {
    first_digit: (0..9),
    second_digit: (0..9),
    third_digit: (0..9)
  }

  attr_accessor :first_digit, :second_digit, :third_digit

  def fitness
    # Try to get the sum of the 3 digits to add up to 15
    (first_digit + second_digit + third_digit - 15).abs
  end
end

describe Darwinning::Implementation do
  let(:triple_pop) { NewTriple.build_population(10, 100, 0) }

  describe '#build_population' do
    it 'creates a population of the correct size' do
      expect(triple_pop.size).to eq 10
    end

    it 'uses the fitness function defined by #fitness' do
      a_triple = triple_pop.members.first
      manual_fitness = (a_triple.first_digit + a_triple.second_digit + a_triple.third_digit - 15).abs

      expect(a_triple.fitness).to eq manual_fitness
    end 
  end

  describe '#genes' do
    it 'creates a gene for every value in GENE_RANGES' do
      expect(NewTriple.genes.size).to eq NewTriple::GENE_RANGES.size
    end
  end
end
