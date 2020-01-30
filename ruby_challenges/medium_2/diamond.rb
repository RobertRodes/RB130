class Diamond
  def self.make_diamond(letter)
    return "A\n" if 'A' == letter
    h_size = (letter.ord - 'A'.ord) * 2 + 1
    lines = 'A'.center(h_size) + "\n"
    letters = [*'B'..letter]

    letters.each_with_index do |l, i| 
      lines << (l + spaces(i * 2 + 1) + l).center(h_size) + "\n"
    end

    2.upto(letters.size) do |n|
      l = letters[-n]
      lines << (l + spaces(h_size - n * 2) + l).center(h_size) + "\n"
    end

    lines << 'A'.center(h_size) + "\n"
  end

  def self.spaces(num)
    ' ' * num
  end
end

def generate_pattern(num)
width = [*1..num].join.size
1.upto(num) { |n| puts [*1..n].join.ljust(width, '*') }
end

# generate_pattern(20)
# puts Diamond.make_diamond('A')
# puts Diamond.make_diamond('C')
# puts Diamond.make_diamond('E')
# puts Diamond.make_diamond('G')
# puts Diamond.make_diamond('^')
