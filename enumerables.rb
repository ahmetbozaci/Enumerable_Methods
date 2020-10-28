module Enumerable
  
  #my_each
  def my_each()
    if block_given?
      for i in self do
        yield i
      end
    else
      to_enum(:my_each)  
    end
  end

  #my_each_with_index
  def my_each_with_index()
    if block_given?
      for i in self do
        if self.class == Range
          yield i, self.to_a.index(i)
        else
          yield i, self.to_a.index(i)
        end
      end
    else
      to_enum(:my_each_with_index)  
    end
  end

  #my_map
  def my_map()
    if block_given?
      arr = Array.new
      self.my_each do |i|
        arr << yield(i)
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
    elsif self.size == 0
      return false

    #if all elements are nil or false  
    elsif self.size > 0 && arg == nil
      nil_count = 0
      for i in self
        if i == nil || i == false
          nil_count += 1
        end
      end
      if nil_count == self.size
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
  end 
  
  #my_all
  def my_all?(arg = nil)
    if block_given?
      self.my_each do |i|
        unless yield(i)
          return false
        end
      end
      true

    #if array empty
    elsif self.size == 0
      return true

    #if one element is nil or false  
    elsif self.include?(nil) || self.include?(false)
      return false

    #if class
    elsif arg.class == Class
      self.my_each do |i|
        unless i.is_a? (arg)
          return false
        end
      end
      true
    
    #if no block given
    elsif arg == nil
      self.my_each do |i|
        if i == false || i == nil
          return false
        end
      end
      true

    #Regexp
    elsif arg.class == Regexp
      self.my_each do |i|
        index = i =~ arg
        unless index.class == Integer
          return false
        end
      end
      true
    end
  end 

  #my_none
  def my_none?(arg = nil)
    if block_given?
      self.my_each do |i|
        if yield(i)
          return false
        end
      end
      true

    #if all element is nil or false  or array is empty 
    elsif self.size >= 0 && arg == nil
        num = 0
        self.my_each do |i|
          if i == nil || i == false
            num += 1
          end
        end
        unless num == self.size
          return false
        end
        true

    #if class
    elsif arg.class == Class
      self.my_each do |i|
        if i.is_a? (arg)
          return false
        end
      end
      true

    #Regexp
    elsif arg.class == Regexp
      self.my_each do |i|
        index = i =~ arg
        if index.class == Integer
          return false
        end
      end
      true
    end
  end 
  
  def my_count(arg = nil)
    if block_given?
      num = 0
      self.my_each do |i|
        if yield(i)
          num += 1
        end
      end
      return num

    #no argument given
    elsif arg == nil
     self.size
    
    #argument given
    else
      num = 0 
      for i in self
        if i == arg
          num += 1
        end 
      end
      num 
    end

  end 

  #my_inject
  def my_inject (num = nil , arg = nil )
    
    if block_given?

      #if no number
      if num == nil 
        i = 0
        result = self.to_a[i]
        while i<self.size-1
          result = yield(result,self.to_a[i+1]) 
          i += 1
        end

      #if number given
      else
        i = 0
        result = num
        while i<self.size
          result = yield(result,self.to_a[i])
          i += 1
        end
      end
      result
    
    elsif num.class == Symbol 
      sum_sub = 0
      product_div = 1
      if num == :+
        for i in self
          sum_sub += i
        end
        return sum_sub

      elsif num == :-
        for i in self
          sum_sub -= i
        end
        return sum_sub

      elsif num == :*
        for i in self
          product_div *= i
        end
        return product_div

      elsif num == :/
        for i in self
          product_div /= i
        end
        return product_div
    end
    
    elsif arg.class == Symbol 
      sum_sub = 0
      product_div = 1
      if arg == :+
        for i in self
          sum_sub += i
        end
      return sum_sub+num

    elsif arg == :-
      for i in self
        sum_sub -= i
      end
      return sum_sub+num

    elsif arg == :*
      for i in self
        product_div *= i
      end
      return product_div*num

    elsif arg == :/
      for i in self
        product_div /= i
      end
      return product_div/num
    end

    elsif num.class == Integer
      raise TypeError.new "#{num} is not a symbol nor a string"    
    else
      raise LocalJumpError.new "no block given"    
    end
  end
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

my_proc = Proc.new {|i| i*2}
arr.my_map(&my_proc)

#my_select
arr.my_select { |num|  num.even?  }   #=> [32, 10, 4]

#my_any
%w{orange banane apple}.my_any? { |word| word.length >= 3 }  #=> true
%w{orange banane apple}.my_any? { |word| word.length >= 10 } #=> false
%w{orange banane apple}.my_any?(/d/)                         #=> false
["a", "a", "1"].my_any?(String)  #=> true
[nil, nil, false].my_any?        #=> false
[].my_any?                       #=> false

#my_all


#my_none
%w{orange banane apple}.my_none? { |word| word.length == 5 } #=> false
%w{orange banane apple}.my_none? { |word| word.length <= 4 } #=> true
%w{orange banane apple}.my_none?(/d/)                        #=> true
[1, 314, 4.2].my_none?(Float)   #=> false
[].my_none?                     #=> true
[nil].my_none?                  #=> true
[nil, false].my_none?           #=> true
[nil, false, true].my_none?     #=> false

#my_count
ary = [4, 5, 2, 2, 6, 7, 2, 2, 3]
ary.my_count                  #=> 9
ary.my_count(2)               #=> 4
ary.my_count { |x| x%2 == 0 } #=> 3

#my_inject
(5..10).my_inject(5){ |sum, n| sum + n }           
(5..50).my_inject { |prod, n| prod * n }
array = [1,2,3,4,8]
array.my_inject(:+)

def multiply_els(arr)
  arr.my_inject(:*)
end

multiply_els([1,3,7,9])