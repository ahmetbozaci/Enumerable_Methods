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

end