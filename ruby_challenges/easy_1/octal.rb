class Octalx
  def initialize(input)
    @input = input
  end

  def to_decimal
    return 0 if @input =~ /[^0-7]/
    @input.to_i.digits.map.with_index { |el, idx| el * 8**idx }.sum
  end
end

class Octal
  attr_reader :octal
  EXCEPTIONS = '(a-z)89'
  BASE = 8

  def initialize(string)
    if string.downcase.count(EXCEPTIONS) > 0
      @octal = [0]
    else
      @octal = string.chars.reverse!.map(&:to_i)
    end
  end

  def to_decimal
    dec_array = []
    octal.each_index do |digit|
      dec_array << octal[digit] * BASE**digit
    end
    dec_array.reduce(:+)
  end
end