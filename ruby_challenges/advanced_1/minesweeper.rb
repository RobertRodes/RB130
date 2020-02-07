ValueError = Class.new(ArgumentError)

class Board
  class << self
    def transform(inp)
      validate(inp)
      inp.each_cons(3) do |row|
        row[1].each_char.with_index do |char, i|
          next unless char == ' '
          stars = 0
          3.times { |j| stars += row[j][i - 1..i + 1].count('*') }
          row[1][i] = stars.to_s if stars > 0
        end
      end
      inp
    end

    private

    def validate(inp)
      raise ValueError.new('Invalid board') if
        inp.map(&:size).uniq.size > 1 ||
        inp.join =~ /[^-+| *]/ ||
        !valid_border?(inp)
    end

    def valid_border?(inp)
      inp.values_at(0, -1).all? { |line| line =~ /^\+-+\+$/ } &&
      inp[1..-2].all? { |line| line =~ /^\|[ *]+\|$/ }
    end
  end
end

# p Board.validate(inp)

# out = [
#   '+------+', 
#   '|1*22*1|', 
#   '|12*322|', 
#   '| 123*2|', 
#   '|112*4*|',
#   '|1*22*2|', 
#   '|111111|', 
#   '+------+'
# ]

# q = Board.transform(inp)
# puts q
# puts q == out