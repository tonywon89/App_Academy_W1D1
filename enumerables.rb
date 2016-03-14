class Array
  def my_each(&blk)
    i = 0
    while i < self.length
      blk.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&blk)
    result = []
    self.my_each do |element|
      result << element if blk.call(element)
    end
    result
  end

  def my_reject(&blk)
    result = []
    self.my_each do |element|
      result << element unless blk.call(element)
    end
    result
  end

  def my_any?(&blk)
    self.my_each do |element|
      return true if blk.call(element)
    end
    false
  end

  def my_all?(&blk)
    self.my_each do |element|
      return false unless blk.call(element)
    end
    true
  end

  def my_flatten
    result = []
    self.my_each do |elem|
      if elem.is_a?(Array)
        flattened_arr = elem.my_flatten
        flattened_arr.my_each do |element|
          result << element
        end
      else
        result << elem
      end
    end
    result
  end

  def my_zip(*arrays)
    zipped = []
    self.each_with_index do |elem, i|
      indexed_arr = []
      indexed_arr << elem
      arrays.each do |array|
        indexed_arr << array[i]
      end
      zipped << indexed_arr
    end
    zipped
  end

  def my_rotate(n = 1)
    if n < 0
      n += self.length
    end

    if n > self.length - 1
      n = n % self.length
    end

    rotated = []
    (n...self.length).each do |index|
      rotated << self[index]
    end
    (0...n).each do |index|
      rotated << self[index]
    end
    rotated
  end

  def my_join(separator = "")
    joined = ""
    self.each do |string|
      joined << string << separator
    end
    joined = joined[0...-1] unless separator.empty?
    joined
  end

  def my_reverse
    reversed = []
    i = -1
    until reversed.length == self.length
      reversed << self[i]
      i -= 1
    end
    reversed
  end
end

if __FILE__ == $PROGRAM_NAME
  p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  p [ 1 ].my_reverse               #=> [1]
end
