module Enumerable
  # my_each
  def my_each()
    if block_given?
      each do |i|
        yield i
      end
    else
      to_enum(:my_each)
    end
  end

  # my_each_with_index
  def my_each_with_index()
    if block_given?
      each do |i|
        if self.class == Range
          yield i, to_a.index(i)
        else
          yield i, to_a.index(i)
        end
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  # my_map
  def my_map()
    if block_given?
      arr = []
      my_each do |i|
        arr << yield(i)
      end
      arr
    else
      to_enum(:my_map)
    end
  end

  # my_select
  def my_select()
    if block_given?
      arr = []
      my_each do |i|
        arr << i if yield(i)
      end
      arr
    else
      to_enum(:my_select)
    end
  end

  # my_any
  def my_any?(arg = nil)
    if block_given?
      my_each do |i|
        return true if yield(i)
      end
      false

    # if array empty
    elsif size == 0
      false

    # if all elements are nil or false
    elsif size > 0 && arg.nil?
      nil_count = 0
      each do |i|
        nil_count += 1 if i.nil? || i == false
      end
      !(nil_count == size)

    # if class
    elsif arg.class == Class
      my_each do |i|
        return true if i.is_a?(arg)
      end
      false

    # Regexp
    elsif arg.class == Regexp
      my_each do |i|
        index = i =~ arg
        return true if index.class == Integer
      end
      false
    end
  end

  # my_all
  def my_all?(arg = nil)
    if block_given?
      my_each do |i|
        return false unless yield(i)
      end
      true

    # if array empty
    elsif size == 0
      true

    # if one element is nil or false
    elsif include?(nil) || include?(false)
      false

    # if class
    elsif arg.class == Class
      my_each do |i|
        return false unless i.is_a?(arg)
      end
      true

    # if no block given
    elsif arg.nil?
      my_each do |i|
        return false if i == false || i.nil?
      end
      true

    # Regexp
    elsif arg.class == Regexp
      my_each do |i|
        index = i =~ arg
        return false unless index.class == Integer
      end
      true
    end
  end

  # my_none
  def my_none?(arg = nil)
    if block_given?
      my_each do |i|
        return false if yield(i)
      end
      true

    # if all element is nil or false  or array is empty
    elsif size >= 0 && arg.nil?
      num = 0
      my_each do |i|
        num += 1 if i.nil? || i == false
      end
      return false unless num == size

      true

    # if class
    elsif arg.class == Class
      my_each do |i|
        return false if i.is_a?(arg)
      end
      true

    # Regexp
    elsif arg.class == Regexp
      my_each do |i|
        index = i =~ arg
        return false if index.class == Integer
      end
      true
    end
  end

  def my_count(arg = nil)
    if block_given?
      num = 0
      my_each do |i|
        num += 1 if yield(i)
      end
      num

    # no argument given
    elsif arg.nil?
      size

    # argument given
    else
      num = 0
      each do |i|
        num += 1 if i == arg
      end
      num
    end
  end

  # my_inject
  def my_inject(num = nil, arg = nil)
    if block_given?

      # if no number
      if num.nil?
        i = 0
        result = to_a[i]
        while i < size - 1
          result = yield(result, to_a[i + 1])
          i += 1
        end

      # if number given
      else
        i = 0
        result = num
        while i < size
          result = yield(result, to_a[i])
          i += 1
        end
      end
      result

    elsif num.class == Symbol
      sum_sub = 0
      product_div = 1
      if num == :+
        each do |i|
          sum_sub += i
        end
        sum_sub

      elsif num == :-
        each do |i|
          sum_sub -= i
        end
        sum_sub

      elsif num == :*
        each do |i|
          product_div *= i
        end
        product_div

      elsif num == :/
        each do |i|
          product_div /= i
        end
        product_div
      end

    elsif arg.class == Symbol
      sum_sub = 0
      product_div = 1
      if arg == :+
        each do |i|
          sum_sub += i
        end
        sum_sub + num

      elsif arg == :-
        each do |i|
          sum_sub -= i
        end
        sum_sub + num

      elsif arg == :*
        each do |i|
          product_div *= i
        end
        product_div * num

      elsif arg == :/
        each do |i|
          product_div /= i
        end
        product_div / num
      end

    elsif num.class == Integer
      raise TypeError, "#{num} is not a symbol nor a string"
    else
      raise LocalJumpError, 'no block given'
    end
  end
end

# EXAMPLES
arr = [32, 10, 21, 4, 5]

# my_each
arr.my_each do |n|
  n += 1
  print "#{n}-"
end

# my_each_with_index
arr.my_each_with_index do |i, n|
  print "#{i}:#{n} - "
end

# my_map
arr.my_map do |i|
  i += 1
  print "#{i} "
end

my_proc = proc { |i| i * 2 }
arr.my_map(&my_proc)

# my_select
arr.my_select { |num| num.even? } #=> [32, 10, 4]

# my_any
%w[orange banane apple].my_any? { |word| word.length >= 3 } #=> true
%w[orange banane apple].my_any? { |word| word.length >= 10 } #=> false
%w[orange banane apple].my_any?(/d/) #=> false
%w[a a 1].my_any?(String) #=> true
[nil, nil, false].my_any? #=> false
[].my_any? #=> false

# my_all

# my_none
%w[orange banane apple].my_none? { |word| word.length == 5 } #=> false
%w[orange banane apple].my_none? { |word| word.length <= 4 } #=> true
%w[orange banane apple].my_none?(/d/) #=> true
[1, 314, 4.2].my_none?(Float) #=> false
[].my_none? #=> true
[nil].my_none? #=> true
[nil, false].my_none? #=> true
[nil, false, true].my_none? #=> false

# my_count
ary = [4, 5, 2, 2, 6, 7, 2, 2, 3]
ary.my_count #=> 9
ary.my_count(2) #=> 4
ary.my_count { |x| x.even? } #=> 3

# my_inject
(5..10).my_inject(5) { |sum, n| sum + n }
(5..50).my_inject { |prod, n| prod * n }
array = [1, 2, 3, 4, 8]
array.my_inject(:+)

def multiply_els(arr)
  arr.my_inject(:*)
end

multiply_els([1, 3, 7, 9])
