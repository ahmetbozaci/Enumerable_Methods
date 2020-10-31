# rubocop:disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

module Enumerable
  # my_each
  def my_each()
    return to_enum(:my_each) unless block_given?

    size.times do |i|
      yield to_a[i]
    end
    self
  end

  # my_each_with_index
  def my_each_with_index()
    return to_enum(:my_each_with_index) unless block_given?

    size.times do |i|
      yield(self[i], i)
    end
    self
  end

  # my_map

  def my_map(proc = nil)
    if block_given? && proc.nil?
      arr = []
      my_each do |i|
        arr << yield(i)
      end
      arr
    elsif !proc.nil?
      arr = []
      my_each do |i|
        arr << proc.call(i)
      end
      arr
    else
      to_enum(:my_map)
    end
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

    # if string or number
    elsif !arg.nil? && arg.class != Regexp
      my_each do |i|
        return true if i == arg
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
    # if argument is number or string
    elsif !arg.nil? && arg.class != Regexp
      my_each do |i|
        return false unless arg == i
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

    # if number or string
    elsif !arg.nil? && arg.class != Regexp
      my_each do |i|
        return false if i == arg
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
      my_each do |n|
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
        result = to_a[0]
        (size - 1).times do |i|
          result = yield(result, to_a[i + 1])
        end

      # if number given
      else
        result = num
        size.times do |i|
          result = yield(result, to_a[i])
        end
      end
      result

    elsif num.class == Symbol
      result = to_a[0]
      (size - 1).times do |i|
        result = result.send(num, to_a[i + 1])
      end
      result

    elsif arg.class == Symbol
      result = num
      size.times do |i|
        result = result.send(arg, to_a[i])
      end
      result

    elsif num.class == Integer
      raise TypeError, "#{num} is not a symbol nor a string"
    else
      raise LocalJumpError, 'no block given'
    end
  end
end

# rubocop:enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

def multiply_els(arr)
  arr.my_inject(:*)
end

multiply_els([1, 3, 7, 9])
