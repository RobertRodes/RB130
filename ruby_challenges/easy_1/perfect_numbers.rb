class PerfectNumber
  def self.classify(num)
    fail "Number must be 1 or higher" if num < 1
    sum_of_divisors = (1..num / 2).select { |n| (num % n).zero? }.sum
    %w(perfect abundant deficient)[sum_of_divisors <=> num]
  end
end

p PerfectNumber.classify(12)
p PerfectNumber.classify(6)
p PerfectNumber.classify(8128)
p PerfectNumber.classify(6349)
p PerfectNumber.classify(-1)