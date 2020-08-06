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
          expect(array.my_each { |i| p i }).to eq(array.each { |i| p i })
        end
      end
    end
    context 'using it with hash' do
      context 'without block' do
        it 'returns enumerator' do
          expect(hash.my_each).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(hash.my_each { |i| p i }).to eq(hash.each { |i| p i })
        end
      end
    end
    context 'using it with range' do
      context 'without block' do
        it 'returns enumerator' do
          expect(range.my_each).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(range.my_each { |i| p i }).to eq(range.each { |i| p i })
        end
      end
    end
  end
  describe '#my_each_with_index' do
    context 'using it with array' do
      context 'without block' do
        it 'returns enumerator' do
          expect(array.my_each_with_index).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(array.my_each_with_index { |w, i| p i, w }).to eq(array.each_with_index { |w, i| p i, w })
        end
      end
    end
    context 'using it with hash' do
      context 'without block' do
        it 'returns enumerator' do
          expect(hash.my_each_with_index).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(hash.my_each_with_index { |w, i| p i, w }).to eq(hash.each_with_index { |w, i| p i, w })
        end
      end
    end
    context 'using it with range' do
      context 'without block' do
        it 'returns enumerator' do
          expect(range.my_each_with_index).to be_kind_of(Enumerator)
        end
      end
      context 'with a block' do
        it 'returns enumerator' do
          expect(range.my_each_with_index { |w, i| p i, w }).to eq(range.each_with_index { |w, i| p i, w })
        end
      end
    end
  end
end
