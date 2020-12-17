require './enumerables'

describe Enumerable do
  
  arr = [32, 10, 21, 4, 5]
  range = (4..10)
  test_block = proc { |n| n += 1 }
  test_block2 = proc {|i, n|print "#{i}:#{n} - "}
  string = %w[orange banana apple]
  describe '#my_each' do
    it 'my_each output has to same with each' do
      expect(arr.my_each(&test_block)).to eql(arr.each(&test_block))
    end

    it 'my_each output has to same with each' do
      expect(range.my_each(&test_block)).to eql(range.each(&test_block))
    end
  
  end

  describe '#my_each_with_index' do
       it 'iterates over a collection elements with index'do
        expect(arr.my_each_with_index(&test_block2)).to eq(arr.each_with_index(&test_block2))
       end 
  end

      it 'tets my_each_with_index on range' do
        expect(range.my_each_with_index(&test_block2)).to eq(range.each_with_index(&test_block2))
      end

  describe '#my_select' do
      it 'tests my_select for a given collection' do
        expect(arr.my_select(&:even?)).to eq(arr.select(&:even?))

      end
  end

  describe '#my_all?' do
    it 'tests my_all? on a block' do
      expect(string.my_all?{ |word| word.length >= 3 }).to eq(string.all?{ |word| word.length >= 3 })
    end

    it 'tests my_all on a range' do
     expect(range.my_all?(4)).to eq(range.all?(4))
    end

    it 'tests my_all on a collection(array)'do
      expect(arr.my_all?(&:odd?)).to eq(arr.all?(&:odd?))
    end
  end

  describe '#my_any?'do
    it 'tests my_any? on a range'do
    expect(range.my_any?(7)).to eq(range.any?(7))
    end

    it 'tests my_any? on a collection(array)'do
      expect(arr.my_any?(10)).to eq(arr.any?(10))
    end

    it 'tests my_any? on a class' do
      expect([3, 'apple', 1].my_any?(String)).to eq([3, 'apple', 1].any?(String))
    end
  end

end

# [1,2,3].my_each(&proc{|x| x>2}) == [1,2,3]