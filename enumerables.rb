module Enumerable
  
  #my_each
  def my_each(&block)
    if block_given?
      for i in self do
        yield i
      end
    else
      to_enum(:my_each)  
    end
  end

  #my_each_with_index
  def my_each_with_index(&block)
    if block_given?
      for i in self do
        yield i, self.index(i)
      end
    else
      to_enum(:my_each_with_index)  
    end
  end

  #my_map
  def my_map(&block)
    if block_given?
      arr = Array.new
      self.my_each do |i|
        arr << block.call(i)
      end
      return arr
    else
      to_enum(:my_map)  
    end
  end

end


#Examples

arr = [32,10,21,4,5]

puts "my_each"
arr.my_each do |n|
  n += 1
  print "#{n}-"
end

puts "my_each_with_index"
arr.my_each_with_index do |i,n|
  print "#{i}:#{n} - "
end

puts "my_map"
arr.my_map do |i|
  i += 1
  print "#{i} "
end
