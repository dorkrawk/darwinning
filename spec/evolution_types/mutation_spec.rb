require 'spec_helper'

describe Darwinning::EvolutionTypes::Mutation do

  describe '#evolve' do
    context 'when the mutation is triggered' do
      # Use a mutation_rate of 1 ... which means a 100% chance of mutation.
      subject { described_class.new(mutation_rate: 1.0) }
      let(:new_gene_variant) { double }

      before do
        allow(gene).to receive(:express).and_return(new_gene_variant)
      end

      shared_examples_for 'a mutation that updates the genotype of the member' do
        before { subject.evolve([member]) }

        it "modifies the member's genotype to be the new expression of the gene" do
          expect(member.genotypes[gene]).to eq(new_gene_variant)
        end
      end

      context 'with a subclass of Organism' do
        let(:member) { Single.new }
        let(:gene) { member.genes[0] }

        it_behaves_like 'a mutation that updates the genotype of the member'
      end

      context 'with a class that includes Darwinning' do
        let(:member) { NewSingle.new }
        let(:gene) { Darwinning::Gene.new(name: :first_digit, value_range: (0..9)) }

        before do
          allow(Darwinning::Gene).to receive(:new)
            .with(name: :first_digit, value_range: (0..9))
            .and_return(gene)
        end

        it_behaves_like 'a mutation that updates the genotype of the member'
      end
    end
  end

end
