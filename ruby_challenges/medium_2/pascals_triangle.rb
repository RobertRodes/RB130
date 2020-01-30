class Triangle
  attr_reader :rows

  def initialize(size)
    @size = size - 1
    @rows = calc_rows
  end

  private

  def calc_rows
    rows = [[1]]
    1.upto(@size - 1) do |i|
      seed = [0, *rows[-1], 0]
      new_row = []
      seed.each_cons(2) { |a, b| new_row << a + b }
      rows << new_row
    end
    rows
  end
end

# t = Time.now
# x = Triangle.new(2000).rows
# p Time.now - t

# p Triangle.new(5).rows
