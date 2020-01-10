class Series
  def initialize(str)
    @str = str
  end

  def slices(how_many)
    raise ArgumentError.new("Size of series can't be larger than #{@str.size}") if how_many > @str.size
    @str.chars.map(&:to_i).each_cons(how_many).to_a
  end
end

# ser = Series.new('01234567')
# p ser.slices(3)