class Sieve
  def initialize(input)
    fail(ArgumentError,
      "Sorry, but 10 seconds is all I'm willing to put into this. " \
      "No numbers greater than 1,000,000."
    ) if input > 10000000
    @input = input
  end

  def primes
    seed_array = 3.step(@input,2).to_a.unshift(2)
    counter = 1
    while counter**2 < seed_array.size
      seed_array.delete_if do |el| 
        el > seed_array[counter] && (el % seed_array[counter]).zero?
      end
      counter += 1
    end
    seed_array
  end
end
