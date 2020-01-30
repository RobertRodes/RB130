class Palindromes
  attr_reader :largest, :smallest

  FactorList = Struct.new(:factors, :value)

  def initialize(max_factor:, min_factor: 1)
    @factors = []
    @max_factor, @min_factor = max_factor, min_factor
  end

  def generate
    all_factors = (@min_factor..@max_factor).to_a.repeated_combination(2).to_a
  
    @factors = all_factors.select! do |x, y| 
      (x * y).to_s == (x * y).to_s.reverse
    end

    value = @factors.map { |ary| ary.reduce(:*) }.max
    @largest = FactorList.new(subset(value), value)

    value = @factors.map { |ary| ary.reduce(:*) }.min
    @smallest = FactorList.new(subset(value), value)
  end

  # def generate
  #   enum1 = (@min_factor..@max_factor).to_enum
  #   enum2 = enum1.clone

  #   loop do
  #     num1 = enum1.next
  #     loop do
  #       num2 = enum2.next
  #       @factors << [num1, num2].sort if 
  #         (num1 * num2).to_s == (num1 * num2).to_s.reverse &&
  #         !@factors.include?([num1, num2].sort)
  #     end
  #     enum2.rewind
  #   end

  #   value = @factors.map { |ary| ary.reduce(:*) }.max
  #   @largest = FactorList.new(subset(value), value)

  #   value = @factors.map { |ary| ary.reduce(:*) }.min
  #   @smallest = FactorList.new(subset(value), value)
  # end

  private

  def subset(value)
    @factors.select { |ary| ary.reduce(:*) == value }
  end
end

class Palindromes2
  attr_reader :max_factor, :min_factor, :palindromes
  def initialize(args)
    @max_factor = args[:max_factor]
    @min_factor = args[:min_factor] || 1
    @palindromes = Hash.new { |hash, key| hash[key] = [] }
  end

  def generate
    (min_factor..max_factor).to_a.repeated_combination(2) do |x,y|
        palindromes[x * y] << [x,y] if palindrome?(x * y)
    end
  end

  def palindrome?(value)
    value.to_s == value.to_s.reverse
  end

  def largest
    Struct.new(:value, :factors).new(largest_product, palindromes[largest_product])
  end

  def smallest
    Struct.new(:value, :factors).new(smallest_product, palindromes[smallest_product])
  end

  def smallest_product
    palindromes.keys.min
  end

  def largest_product
    palindromes.keys.max
  end
end

class Palindromes3
  attr_reader :min_factor, :max_factor, :palindromes

  Palindrome = Struct.new(:factors, :value)

  def initialize(min_factor: 1, max_factor: nil)
    @min_factor = min_factor
    @max_factor = max_factor
  end

  def generate
    @palindromes = (min_factor..max_factor)
      .to_a
      .repeated_combination(2)
      .each_with_object({}) do |(num1, num2), result|
      if palindrome? num1 * num2
        result[num1 * num2] ||= []
        result[num1 * num2] << [num1, num2]
      end
    end.sort
  end

  def largest
    palindrome = palindromes.last
    Palindrome.new(palindrome[1], palindrome[0])
  end

  def smallest
    palindrome = palindromes.first
    Palindrome.new(palindrome[1], palindrome[0])
  end

  private

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end
end

class Palindromes4
  def initialize(max_factor:, min_factor: 1)
    @factors = factors(max_factor, min_factor)
  end

  def generate
    @factors.select! do |candidate|
      (candidate[0] * candidate[1]).to_s == (candidate[0] * candidate[1]).to_s.reverse
    end
  end

  def largest
    max = @factors.map { |factor| factor[0] * factor[1] }.max
    factors = @factors.select { |factor| factor[0] * factor[1] == max }
    Palindrome.new(max, factors)
  end

  def smallest
    min = @factors.map { |factor| factor[0] * factor[1] }.min
    factors = @factors.select { |factor| factor[0] * factor[1] == min }
    Palindrome.new(min, factors)
  end

  private

  def factors(max, min)
    (min..max).to_a.combination(2).to_a + (min..max).to_a.map { |num| [num, num] }
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end


# p1 = Palindromes.new(max_factor: 999, min_factor: 100)
# p2 = Palindromes2.new(max_factor: 999, min_factor: 100)
# p3 = Palindromes3.new(max_factor: 999, min_factor: 100)
# p4 = Palindromes4.new(max_factor: 999, min_factor: 100)

# # binding.pry
# t = Time.now
# p1.generate
# p Time.now - t
# t = Time.now
# p2.generate
# p Time.now - t
# t = Time.now
# p3.generate
# p Time.now - t
# t = Time.now
# p4.generate
# p Time.now - t
# # exit

pals = Palindromes.new(max_factor: 999, min_factor: 100)

pals.generate
# p Time.now - t
p pals.largest
p pals.largest.factors
p pals.largest.value
# binding.pry
p pals.smallest.factors
p pals.smallest.value
