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
      return false if block_given? && [false, nil].include?(yield(item))
      return false if !block_given? && [false, nil].include?(item)
      return true if item == last
    end
  end

  def my_any?
    my_each do |item|
      return true if block_given? && ![false, nil].include?(yield(item))
      return true if !block_given? && ![false, nil].include?(item)
      return false if item == last
    end
  end

  def my_none?
    my_each do |item|
      return false if block_given? && yield(item) == true
      return false if !block_given? && item == true
      return true if item == last
    end
  end

  def my_count(*args)
    counter = 0
    my_each do |item|
      if block_given?
        counter += 1 if yield(item)
      elsif !block_given? && args.length == 1
        counter += 1 if args[0] == item
      else
        counter += 1
      end
    end
    counter
  end

  def my_map
    new_array = []
    if block_given?
      my_each_with_index do |item, index|
        new_array[index] = yield(item)
      end
      new_array
    else
      to_enum(:my_map)
    end
  end

=begin
1  - check for existance of the operation symbol and the initial value
1.1- store the initial value in accumulator variable (e.g memo variable)
1.2- start looping through the elements of the collection
1.3- in every iteration excute the given operation or the spicified operation with the 
  symbol variable and store the result in the memo variable for the next operation

2  - check if we don't have initial value but only symbol
2.1- set the initial value to the first element of the array
2.2- start looping through the elements of the collection
2.3- in every iteration excute the given operation or the spicified operation with the 
  symbol variable and store the result in the memo variable for the next operation
2.4- return the memo variable  

=end

  def my_inject(*args)
    if args.length == 2
      memo = args[0]
      my_each do |item|
        case args[1]
        when :+
          memo += item 
        when :*
          memo *= item
        when :-
          memo -= item
        when :/
          memo /= item
        end    
      end
      memo
    end
    if args.length == 1
      my_each do |item|
        if defined?(memo) == nil
          memo = item
        else  
          case args[0]
          when :+
            memo += item 
          when :*
            memo *= item
          when :-
            memo -= item
          when :/
            memo /= item
          end    
        end
      end
      memo
    end
  end
end

p [1,2,3].my_inject(:+)
