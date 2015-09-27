require 'spec_helper'

describe Darwinning do
  let(:triple_pop) { NewTriple.build_population(0, 20, 1000) }
  let(:triple_pop_member) { triple_pop.members.first }

  describe '#build_population' do
    it 'creates a population of the correct size' do
      expect(triple_pop.size).to eq 20
    end

    it 'creates a population with the correct generation limit' do
      expect(triple_pop.generations_limit).to eq 1000
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

  describe '#is_evolveable?' do
    it 'is true for a class that implments the necessary Darwinning features' do
      expect(NewTriple.is_evolveable?).to be true
    end

    it 'is false if the class is missing get GENE_RANGES constant' do
      expect(GenelessChimp.is_evolveable?).to be false
    end

    it 'is false if GENE_RANGES not a Hash' do
      expect(BadGenesChimp.is_evolveable?).to be false
    end

    it 'is false if the genes are invalid' do
      expect(NoValuesChimp.is_evolveable?).to be false
    end

    it 'is false if GENE_RANGES is empty' do
      expect(EmptyGenesChimp.is_evolveable?).to be false
    end

    it 'is false if the class is missing a fitness method' do
      expect(GenelessChimp.is_evolveable?).to be false
    end
  end

  describe 'population member' do 
    it 'is of the parent class' do
      expect(triple_pop_member.class.name).to eq "NewTriple"
    end

    it 'has genotype values validly set' do
      expect(NewTriple.genes.first.value_range).to include(triple_pop_member.send(NewTriple.genes.first.name))
    end

    it 'has a genes method' do
      expect(triple_pop_member.respond_to?(:genes)).to be true
    end

    it 'has genes that are Darwinning::Genes' do
      gene_classes = triple_pop_member.genes.map { |g| g.class.name }.uniq.compact
      expect(gene_classes).to eq ["Darwinning::Gene"]
    end

    it 'has gene for each of the class defined genes' do
      expect(triple_pop_member.genes).to eq NewTriple.genes
    end

    it 'has a genotypes method' do
      expect(triple_pop_member.respond_to?(:genotypes)).to be true
    end

    it 'has genotype values for every gene' do
      genotype_values_equal = triple_pop_member.genotypes.map { |k, v| v == triple_pop_member.send(k.name) }.uniq.compact
      expect(genotype_values_equal).to eq [true]
    end
  end
end
