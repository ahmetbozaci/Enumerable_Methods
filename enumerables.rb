# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

module Enumerable
  # my_each
  def my_each()
    return to_enum(:my_each) unless block_given?

    size.times do |i|
      yield self[i]
    end
    self
  end

  # my_each_with_index
  def my_each_with_index()
    return to_enum(:my_each_with_index) unless block_given?

    my_each do |i|
      yield i, to_a.index(i)
    end
  end

  # my_map
  def my_map()
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each do |i|
      arr << yield(i)
    end
    arr
  end

  # my_select
  def my_select()
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each do |i|
      if yield(i)
        arr << i if yield(i)
      end
    end
    arr
  end

  # my_any

  def my_any?(arg = nil)
    if block_given?
      my_each do |i|
        return true if yield(i)
      end
      false

    # if array empty
    elsif size.zero?
      false

    # if all elements are nil or false
    elsif size.positive? && arg.nil?
      nil_count = 0
      my_each do |i|
        nil_count += 1 if i.nil? || i == false
      end
      nil_count != size # if all elements are nil or false "return false" otherwise "return true"

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
      each do |i|
        return false unless yield(i)
      end
      true

    # if array empty
    elsif size.zero?
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

  # my_count

  def my_count(arg = nil)
    if block_given?
      num = 0
      each do |i|
        num += 1 if yield(i)
      end
      num

    # no argument given
    elsif arg.nil?
      size
    # argument given
    else
      num = 0
      each do |n|
        num += 1 if n == arg
      end
      num
    end
  end

  # my_inject
  def my_inject(num = nil, arg = nil)
    if block_given?

      # if no number
      if num.nil?
        start = 0
        result = to_a[start]
        while start < size - 1
          result = yield(result, to_a[start + 1])
          start += 1
        end

      # if number given
      else
        result = num
        start = 0
        while start < size
          result = yield(result, to_a[start])
          start += 1
        end
      end
      result
    elsif num.class == Symbol
      sum_sub = 0
      product_div = 1
      if num == :+
        my_each do |n|
          sum_sub += n
        end
        sum_sub

      elsif num == :-
        my_each do |n|
          sum_sub -= n
        end
        sum_sub

      elsif num == :*
        my_each do |n|
          product_div *= n
        end
        product_div

      elsif num == :/
        my_each do |n|
          product_div /= n
        end
        product_div
      end
    elsif arg.class == Symbol
      sum_sub = 0
      product_div = 1
      if arg == :+
        my_each do |n|
          sum_sub += n
        end
        sum_sub + num

      elsif arg == :-
        my_each do |n|
          sum_sub -= n
        end
        sum_sub + num

      elsif arg == :*
        my_each do |n|
          product_div *= n
        end
        product_div * num

      elsif arg == :/
        my_each do |n|
          product_div /= n
        end
        product_div / num
      end

    elsif num.class == Integer
      raise TypeError "#{num} is not a symbol nor a string"
    else
      raise LocalJumpError 'no block given'
    end
  end
end

# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

def multiply_els(arr)
  arr.my_inject(:*)
end

multiply_els([1, 3, 7, 9])

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
arr.my_select(&:even?) #=> [32, 10, 4]

# my_any
%w[orange banane apple].my_any? { |word| word.length >= 3 } #=> true
%w[orange banane apple].my_any? { |word| word.length >= 10 } #=> false
%w[orange banane apple].my_any?(/d/) #=> false
[3, 'apple', 1].my_any?(String) #=> true
[nil, nil, false].my_any? #=> false
[].my_any? #=> false

# my_all
%w[orange banana apple].my_all? { |word| word.length >= 3 } #=> true
%w[orange banana apple].my_all? { |word| word.length >= 4 } #=> false
%w[orange banana apple].my_all?(/t/) #=> false
[1, 2i, 3.14].my_all?(Numeric) #=> true
[nil, true, 99].my_all? #=> false
[].my_all? #=> true

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
ary.my_count
ary.my_count(2)

# my_inject
(5..10).my_inject(5) { |sum, n| sum + n }
(5..50).my_inject { |prod, n| prod * n }
array = [1, 2, 3, 4, 8]
array.my_inject(:+)
