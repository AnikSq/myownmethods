# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < length
      yield(*self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(*self[i], i)
      i += 1
    end
  end

  def my_select
    i = 0
    arr = []
    while i < length
      arr << self[i] if yield(*self[i])
      i += 1
    end
    arr
  end

  def my_all?
    i = 0
    while i < length
      return false unless yield(*self[i])

      i += 1
    end
    true
  end

  def my_none?
    i = 0
    while i < length
      return false if yield(*self[i])

      i += 1
    end
    true
  end

  def my_count
    i = 0
    count = 0
    while i < length
      next unless block_given?

      count += 1 if yield(*self[i])
      i += 1
    end
    return i + 1
    count
  end

  def my_map(*prc)
    i = 0
    arr = []
    if prc.length.positive?
      while i < length
        arr.push(prc[0].call(self[i]))
        i += 1
      end
    else
      while i < length
        arr.push(yield(*self[i]))
        i += 1
      end
    end
    arr
  end

  def my_inject(*val)
    i = 0
    if val.length.zero?
      while i < length - 1
        self[0] = yield(*self[0], self[i + 1])
        i += 1
      end
      self[0]
    else
      while i < length
        val = yield(*val, self[i])
        i += 1
      end
      val
    end
  end
end

def multiply_els(pe)
  puts pe.inject { |initial, val| initial *= val }
end

prc = proc { |ele| ele * 2 }
p [1, 2, 3, 4, 5].my_map(prc)
