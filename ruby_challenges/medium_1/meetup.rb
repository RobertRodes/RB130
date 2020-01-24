require 'date'

class Meetup
  DOW = {
    sunday:    0,
    monday:    1,
    tuesday:   2,
    wednesday: 3,
    thursday:  4,
    friday:    5,
    saturday:  6
  }

  WOM = {
    first:   0,
    second:  7,
    third:  14,
    fourth: 21,
    teenth:  0
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(dow, wom)
    return day_last(dow) if wom == :last
    d = Date.new(@year, @month, wom == :teenth ? 13 : 1)
    d + ((DOW[dow] - d.wday + 7) % 7) + WOM[wom]
  end

  private

  def day_last(dow)
    d = Date.new(@year, @month, -1)
    d - (d.wday - DOW[dow] )# % 7
  end
end
