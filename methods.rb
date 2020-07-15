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
      if block_given? && yield(item)
        counter += 1
      elsif !block_given? && args.length == 1 && args[0] == item
        counter += 1
      elsif !block_given? && args.length.zero?
        counter += 1
      end
      # counter += 1 if block_given? && yield(item)
      # counter += 1 if !block_given? && args.length == 1 && args[0] == item
      # counter += 1 if !block_given? && args.length.zero?
    end
    counter
  end
end
