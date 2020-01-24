require 'prime'
class Prime2
  def self.nth(num)
    fail ArgumentError.new('Number must be an integer greater than zero') if 
      num < 1 || num.class != Integer
    return 2 if 1 == num
    prime_count = 2
    prime_candidate = 3
    while prime_count < num
      prime_candidate += 2
      prime_count += 1 if is_prime?(prime_candidate)
    end
    prime_candidate
  end

  private

  def self.is_prime?(num)
    return false if num.even? || 1 == num
    counter = 3
    while counter <= Math.sqrt(num)
      return false if (num % counter).zero?
      counter += 2
    end
    true
  end
end
require 'pry'
class Prime
  def self.nth(num)
    fail ArgumentError unless num > 0
    @primes = [2]
    current_num = 3
    while @primes.length < num
      @primes << current_num if is_prime?(current_num)
      current_num += 2
    end
    @primes.last
  end

  def self.is_prime?(num)
    @primes.each do |prime|
      binding.pry
      return false if num % prime == 0
      break true if prime > Math.sqrt(num)
    end
  end
end

t = Time.now
x = Prime.nth(10)
puts Time.now - t
