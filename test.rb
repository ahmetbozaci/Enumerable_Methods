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
