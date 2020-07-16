# adding my_each method to enumerable module
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
module Enumerable
  def my_each
    if block_given?
      i = 0
      loop do
        yield(self[i])
        i += 1
        break if i == size
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      new_array = []
      current_index = 0
      my_each do |item|
        if yield(item)
          new_array[current_index] = item
          current_index += 1
        end
      end
      new_array
    else
      to_enum(:my_select)
    end
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

  def my_map(*args)
    new_array = []
    if !args.empty?
      my_each_with_index do |item, index|
        new_array[index] = args[0].call(item)
      end
      new_array
    elsif block_given?
      my_each_with_index do |item, index|
        new_array[index] = yield(item)
      end
      new_array
    else
      to_enum(:my_map)
    end
  end

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
    end
    if args.length == 1
      my_each_with_index do |_item, i|
        if i.zero?
          memo = self[i]
        else
          case args[0]
          when :+
            # memo = 0
            memo += self[i]
          when :*
            # memo = 1
            memo *= self[i]
          when :-
            # memo = 0
            memo -= self[i]
          when :/
            # memo = 1
            memo /= self[i]
          end
        end
      end
    end
    if block_given? && args.length == 1
      memo = args[0]
      my_each do |item|
        memo = yield(memo, item)
      end
    end
    return memo unless block_given? and args.empty?

    my_each_with_index do |_item, i|
      memo = if i.zero?
               self[i]
             else
               yield(memo, self[i])
             end
    end
    memo
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
# proc_map = Proc.new { |i| i * i }
# p [1,2,3].my_map(proc_map) {|i| i + i}
# p multiply_els([2,4,5])
# p [1,2,3].my_inject
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
