# require 'pry'
class SumOfMultiples
  def initialize(*mults)
    @mults = mults.empty? ? [3, 5] : mults
  end

  def self.to(limit)
    calc_sum(limit, [3, 5])
  end

  def to(limit)
    self.class.calc_sum(limit, @mults)
  end

  private

  def self.calc_sum(limit, mults)
    (1...limit).reduce(0) do |acc, num| 
      mults.any? { |m| (num % m).zero? } ? num + acc : acc
    end
  end
end


# p SumOfMultiples.new(7, 13, 17).to(20)
# p SumOfMultiples.new.to(20)

# p (7...20).reduce(0) { |acc, num| (num % 13).zero? || (num % 17).zero? ? acc + num : acc  }

