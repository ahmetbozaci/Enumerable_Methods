require './enumerables'

describe Enumerable do
  arr = [32, 10, 21, 4, 5]
  range = (4..10)
  test_block = proc { |n| n + 1 }
  test_block2 = proc { |i, n| print "#{i}:#{n} - " }
  string = %w[orange banana apple]
  describe '#my_each' do
    it 'my_each with array output has to same with each' do
      expect(arr.my_each(&test_block)).to eql(arr.each(&test_block))
    end

    it 'my_each with range output has to same with each' do
      expect(range.my_each(&test_block)).to eql(range.each(&test_block))
    end
  end

  describe '#my_each_with_index' do
    it 'iterates over a collection elements with index' do
      expect(arr.my_each_with_index(&test_block2)).to eq(arr.each_with_index(&test_block2))
    end
    it 'test my_each_with_index on range' do
      expect(range.my_each_with_index(&test_block2)).to eq(range.each_with_index(&test_block2))
    end
  end

  describe '#my_select' do
    it 'tests my_select for a given collection' do
      expect(arr.my_select(&:even?)).to eq(arr.select(&:even?))
    end
  end

  describe '#my_all?' do
    it 'tests my_all? on a block' do
      expect(string.my_all? { |word| word.length >= 3 }).to eq(string.all? { |word| word.length >= 3 })
    end

    it 'tests my_all on a range' do
      expect(range.my_all?(4)).to eq(range.all?(4))
    end

    it 'tests my_all on a collection(array)' do
      expect(arr.my_all?(&:odd?)).to eq(arr.all?(&:odd?))
    end
  end

  describe '#my_any?' do
    it 'tests my_any? on a range' do
      expect(range.my_any?(7)).to eq(range.any?(7))
    end

    it 'tests my_any? on a collection(array)' do
      expect(arr.my_any?(10)).to eq(arr.any?(10))
    end

    it 'tests my_any? on a class' do
      expect([3, 'apple', 1].my_any?(String)).to eq([3, 'apple', 1].any?(String))
    end
  end

  describe '#my_map' do
    it 'my_map output has to give same with map' do
      expect(arr.my_map { |i| i**2 }).to eql(arr.map { |i| i**2 })
    end

    it 'my_map output has to give same with map' do
      expect(arr.my_map(&test_block)).to eql(arr.map(&test_block))
    end
  end

  describe '#my_count' do
    it 'without argument my_count output give same with count' do
      expect(arr.my_count).to eql(arr.count)
    end
    it 'with argument my_count output give same with count' do
      expect(arr.my_count(2)).to eql(arr.count(2))
    end
  end

  describe '#my_none?' do
    it 'my_none? with block should give same output as none?' do
      expect(string.my_none? { |word| word.length == 5 }).to eql(string.none? { |word| word.length == 5 })
    end
  end

  describe '#my_inject' do
    it 'my_inject with block should give same output as inject' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql((5..10).inject { |sum, n| sum + n })
    end
    it 'my_inject with block and argument should give same output as inject' do
      expect((5..50).my_inject(5) { |prod, n| prod * n }).to eql((5..50).inject(5) { |prod, n| prod * n })
    end
    it 'my_inject with symbol should give same output as inject' do
      expect(arr.my_inject(:+)).to eql(arr.inject(:+))
    end
  end
end
