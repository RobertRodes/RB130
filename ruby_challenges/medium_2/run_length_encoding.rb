class RunLengthEncoding
  class << self
    def encode(input)
      input.scan(/((.)\2*)/).map { |a, b| [(a.size if a.size > 1), b] }.flatten.join
    end

    def decode(input)
      input.scan(/\d*[^\d]/).map do |seg| 
        num = seg[0..-2].to_i
        seg[-1] * (num.zero? ? 1 : num)
      end.join
    end
  end
end

# x = RunLengthEncoding.encode('zzz ZZ  zZ')
# p x
# p RunLengthEncoding.decode(x)