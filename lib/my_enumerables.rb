module Enumerable
  # Your code goes here
  def my_each
    for elem in self
      yield elem
    end
    return self
  end

  def my_each_with_index
    for index in 0...self.length
      yield(self[index], index)
    end
    return self
  end

  def my_all?
    repeated_elem = nil
    self.my_each { |value| return false if !yield value }
    return true
  end

  def my_any?
    self.my_each { |value| return true if yield(value) }
    return false
  end

  def my_count
    return self.length if !block_given?
    count = 0
    self.my_each { |value| count += 1 if yield(value) }
    return count
  end

  def my_inject(initial)
    collector = initial
    self.my_each { |value|
      if collector.nil?
        collector = value
      else
        collector = yield(collector, value)
      end
    }
    return collector
  end

  def my_map
    new_enumerable = []
    self.my_each { |value| new_enumerable.append(yield(value)) }
    return new_enumerable
  end

  def my_none?
    self.my_each{ |value| return false if yield value }
    return true
  end

  def my_select
    result = []
    self.my_each { |value| result<<value if yield value}
    return result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  include Enumerable
end
