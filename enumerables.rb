module Enumerable
  
  #my_each
  def my_each(&block)
    if block_given?
      for i in self do
        yield i
      end
    else
      return "#<Enumerator: #{self}:my_each>"
    end
  end

  #my_each_with_index
  def my_each_with_index(&block)
    if block_given?
      for i in self do
        yield i, self.index(i)
      end
    else
      return "#<Enumerator: #{self}:my_each_with_index>"
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
      return "#<Enumerator: #{self}:my_map>"
    end
  end

end