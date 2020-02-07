class Triplet
  include Math
  extend Math

  def initialize(a, b, c)
    @a, @b, @c = a, b, c
  end

  def self.where(min_factor: 1, max_factor:, sum: nil)
    [*min_factor..max_factor].combination(2).with_object([]) do |(a, b), trips|
      c = hypot(a, b)
      next unless c == c.floor && c <= max_factor
      trip = new(a, b, c.to_i)
      trips << trip if !sum || sum == trip.sum
    end
  end

  def product
    [@a, @b, @c].reduce(:*)
  end

  def pythagorean?
    hypot(@a, @b) == @c && @c == @c.floor
  end

  def sum
    [@a, @b, @c].sum
  end
end

# x = Triplet.where(max_factor: 100, sum: 180)
# prod = x.map do |pp| 
#   pp.product
# end
# p prod

# p Triplet.new(3,4,5).pythagorean?