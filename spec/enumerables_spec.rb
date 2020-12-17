require './enumerables'

describe Enumerable do
  arr = [32, 10, 21, 4, 5]
  range = (4..10)
  test_block = proc { |n| n += 1 }
  
 
  describe '#my_each' do
    it 'my_each output has to same with each' do
      expect(arr.my_each(&test_block)).to eql(arr.each(&test_block))
    end

    it 'my_each output has to same with each' do
      expect(range.my_each(&test_block)).to eql(range.each(&test_block))
    end
  
  end
end

# [1,2,3].my_each(&proc{|x| x>2}) == [1,2,3]