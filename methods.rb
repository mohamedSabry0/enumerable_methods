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
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    current_index = 0
    my_each do |item|
      if yield(item)
        new_array[current_index] = item
        current_index += 1
      end
    end
    new_array
  end

  def my_all?
    my_each do |item|
      if block_given?
        if yield(item) == false
          return false
        elsif item == last
          return true
        end
      else
        if item == false || item == nil
          return false
        elsif item == last
          return true
        end
      end
    end
  end
end
