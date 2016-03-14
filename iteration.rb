def factors(num)
  factors = []
  1.upto(num) do |factor|
    factors << factor if num % factor == 0
  end
  factors
end

class Array

  def bubble_sort
    self.dup.bubble_sort!
  end

  def bubble_sort!(&prc)
    if !block_given?
      prc = Proc.new {|num1, num2| num1 <=> num2}
    end
    swapped = true
    until swapped == false
      swapped = false
      self.each_with_index do |elem, i|
        break if i == self.length - 1
        if prc.call(self[i], self[i+1]) == 1
          swapped = true
          self[i], self[i+1] = self[i+1], self[i]
        end
      end
    end
    self
  end

end

def substrings(string)
  substrings = []
  string.chars.each_with_index do |char, i|
    j = i
    while j < string.length
      substrings << string[i..j]
      j += 1
    end
  end
  substrings
end

def subwords(word, dictionary)
  dictionary.select do |entry|
    substrings(word).include?(entry)
  end
end
