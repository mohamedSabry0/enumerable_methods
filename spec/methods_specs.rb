require_relative '../lib/methods'

describe Enumerable do
  let(:array) { Array.new(5) { |i| i } }
  let(:range) { Range.new(1, 5) }
  let(:hash) { { one: '1', two: '2' } }
  describe '#my_each' do
    context 'using it with array' do
      context 'without block' do
        it 'returns enumerator' do
          expect(array.my_each).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(array.my_each { |i| puts i }).to eq(array.each { |i| puts i })
        end
      end
    end
  end
end
