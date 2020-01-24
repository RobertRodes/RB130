class Clock
  include Comparable
  MINS_IN_HOUR = 60
  HOURS_IN_DAY = 24

  def initialize(hour, min)
    @hour = hour
    @min = min
  end

  def self.at(hour, min = 0)
    new(hour, min)
  end

  def +(mins)
    move_mins(mins)
    self
  end

  def -(mins)
    move_mins(-mins)
    self
  end

  def <=>(clock2)
    (@hour * MINS_IN_HOUR + @min) <=> (clock2.hour * MINS_IN_HOUR + clock2.min)
  end

  def to_s
    format("%02d:%02d", @hour, @min)
  end

  protected

  attr_reader :hour, :min

  private

  def move_mins(mins)
    @min = (@min + mins) % MINS_IN_HOUR
    @hour += @min / MINS_IN_HOUR
    @hour %= HOURS_IN_DAY
  end
end
