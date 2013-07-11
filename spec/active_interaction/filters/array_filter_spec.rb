require 'spec_helper'

describe ActiveInteraction::ArrayFilter do
  include_context 'filters'
  it_behaves_like 'a filter'

  describe '.prepare(key, value, options = {}, &block)' do
    context 'with an Array' do
      let(:value) { [] }

      it 'returns the Array' do
        expect(result).to eql value
      end
    end

    context 'with block as a valid block' do
      let(:block) { Proc.new { array } }

      context 'with an Array of Arrays' do
        let(:value) { [[]] }

        it 'returns the Array' do
          expect(result).to eql value
        end
      end

      context 'with an Array of anything else' do
        let(:value) { [Object.new] }

        it 'raises an error' do
          expect { result }.to raise_error ActiveInteraction::InvalidValue
        end
      end
    end

    context 'with block as a nested block' do
      let(:block) { Proc.new { array { array } } }
      let(:value) { [[[]]] }

      it 'returns the Array' do
        expect(result).to eql value
      end
    end

    context 'with block as an invalid block' do
      let(:block) { Proc.new { array; array } }
      let(:value) { [] }

      it 'raises an error' do
        expect { result }.to raise_error ArgumentError
      end
    end
  end
end