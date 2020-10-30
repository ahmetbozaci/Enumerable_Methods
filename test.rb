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
%w[orange banane apple].my_any? { |word| word.length >= 3 }
%w[orange banane apple].my_any? { |word| word.length >= 10 }
%w[orange banane apple].my_any?(/d/)
[3, 'apple', 1].my_any?(String)
[nil, nil, false].my_any?
[].my_any?

# my_all
%w[orange banana apple].my_all? { |word| word.length >= 3 }
%w[orange banana apple].my_all? { |word| word.length >= 4 }
%w[orange banana apple].my_all?(/t/)
[1, 2i, 3.14].my_all?(Numeric)
[nil, true, 99].my_all?
[].my_all?

# my_none
%w[orange banane apple].my_none? { |word| word.length == 5 }
%w[orange banane apple].my_none? { |word| word.length <= 4 }
%w[orange banane apple].my_none?(/d/)
[1, 314, 4.2].my_none?(Float)
[].my_none?
[nil].my_none?
[nil, false].my_none?
[nil, false, true].my_none?

# my_count
ary = [4, 5, 2, 2, 6, 7, 2, 2, 3]
ary.my_count
ary.my_count(2)

# my_inject
(5..10).my_inject(5) { |sum, n| sum + n }
(5..50).my_inject { |prod, n| prod * n }
array = [1, 2, 3, 4, 8]
array.my_inject(:+)
