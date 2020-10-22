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

   #my_select
   def my_select()
    if block_given?
      arr = Array.new
      self.my_each do |i|
        if yield(i)
          arr << i
        end
      end
      return arr
    else
      return to_enum(:my_select)
    end
  end
  
  #my_any
  def my_any?(arg = nil)
    if block_given?
      self.my_each do |i|
        if yield(i)
          return true
        end
      end
      false

    #if array empty
    elsif self.length == 0
      return false

    #if all elements are nil or false  
    elsif self.length > 0 && arg == nil
      nil_count = 0
      for i in self
        if i == nil || i == false
          nil_count += 1
        end
      end
      if nil_count == self.length
        return false
      else
        return true
      end
    
    #if class
    elsif arg.class == Class
      self.my_each do |i|
        if i.is_a? (arg)
          return true
        end
      end
      false

    #Regexp
    elsif arg.class == Regexp
      self.my_each do |i|
        index = i =~ arg
        if index.class == Integer
          return true
        end
      end
      false
    end
  end #def 

end



#EXAMPLES
arr = [32,10,21,4,5]

#my_each
arr.my_each do |n|
  n += 1
  print "#{n}-"
end

#my_each_with_index
arr.my_each_with_index do |i,n|
  print "#{i}:#{n} - "
end

#my_map
arr.my_map do |i|
  i += 1
  print "#{i} "
end

#my_select
arr.my_select { |num|  num.even?  }   #=> [32, 10, 4]

#my_any
%w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].my_any? { |word| word.length >= 6 } #=> false
%w[ant bear cat].my_any?(/d/)                        #=> false
["a", "a", "1"].my_any?(String)                      #=> true
[nil, nil, false].my_any?                            #=> false
[].my_any?                                           #=> false