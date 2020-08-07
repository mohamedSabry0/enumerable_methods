# adding my_each method to enumerable module
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/BlockNesting
module Enumerable
  def my_each
    if block_given?
      if self.class == Range
        new_array = to_a
        i = 0
        loop do
          yield(new_array[i])
          i += 1
          break if i == size
        end
      elsif self.class == Hash
        new_array = to_a
        i = 0
        loop do
          yield(new_array[i])
          i += 1
          break if i == size
        end
      elsif self.class == Array
        i = 0
        loop do
          yield(self[i])
          i += 1
          break if i == size
        end
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      my_each do |item|
        yield(item, i)
        i += 1
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      if self.class == Hash
        new_hash = {}
        my_each do |item|
          if yield(item)
            new_hash[item[0]] = item[1]
          end
        end
        new_hash
      else
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
    else
      to_enum(:my_select)
    end
  end

  def my_all?(*args)
    my_each do |item|
      return false if block_given? && [false, nil].include?(yield(item))
      return false if !block_given? && [false, nil].include?(item)
      return false if !args.empty? && args[0].class == Regexp && !args[0].match(item)
      return false if !args.empty? && args[0].class == Class && !item.is_a?(args[0])
      return false if !args.empty? && ![Class, Regexp].include?(args[0].class) && args[0] != item
      return true if item == last
    end
  end

  def my_any?(*args)
    my_each do |item|
      return true if block_given? && ![false, nil].include?(yield(item))
      return true if args.empty? && !block_given? && ![false, nil].include?(item)
      return true if !args.empty? && args[0].class == Regexp && args[0].match(item)
      return true if !args.empty? && args[0].class == Class && item.is_a?(args[0])
      return true if !args.empty? && ![Class, Regexp].include?(args[0].class) && args[0] == item
      return false if item == last
    end
  end

  def my_none?(*args)
    my_each do |item|
      return false if block_given? && yield(item) == true
      return false if args.empty? && !block_given? && item == true
      return false if !args.empty? && args[0].class == Regexp && args[0].match(item)
      return false if !args.empty? && args[0].class == Class && item.is_a?(args[0])
      return false if !args.empty? && ![Class, Regexp].include?(args[0].class) && args[0] == item
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
    yield if !block_given? && args.empty?
    if self.class == Range
      new_array = to_a
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
            memo = new_array[i]
          else
            case args[0]
            when :+
              memo += new_array[i]
            when :*
              memo *= new_array[i]
            when :-
              memo -= new_array[i]
            when :/
              memo /= new_array[i]
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
                 new_array[i]
               else
                 yield(memo, new_array[i])
               end
      end
      return memo
    end
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
            memo += self[i]
          when :*
            memo *= self[i]
          when :-
            memo -= self[i]
          when :/
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

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/BlockNesting
