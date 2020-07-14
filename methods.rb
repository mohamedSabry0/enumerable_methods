# adding my_each method to enumerable module
module Enumerable
  def my_each
    i = 0
    loop do
      yield(self[i])
      i += 1
      break if i == size
    end
    self
  end
  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end
  end  
end

p [1,2,3].my_each_with_index {|item, index| puts "The value is #{item} an its index is #{index}"}