# nodoc
class Frame
  attr_reader :roll_count, :rolls, :frame_num

  def initialize(frame_num)
    @frame_num = frame_num
    @rolls = []
  end

  def process_roll(pins)
    @rolls << pins
  end

  def roll_count
    @rolls.size
  end

  def score
    @rolls.sum
  end
end

# nodoc
class Game
  ERRMSG = {
    badrollsize: 'Pins must have a value from 0 to 10',
    badpincount: 'Pin count exceeds pins on the lane',
    scorebeforefills: 'Game is not yet over, cannot score!',
    scorebeforegame: 'Score cannot be taken until the end of the game',
    gameoverroll: 'Should not be able to roll after game is over'
  }.freeze

  def initialize
    @next_frame_num = 1
    @game_over = false
    @frames = []
    next_frame
  end

  def roll(pins)
    roll_error_check(pins)
    @frames.last.frame_num <= 10 ? process_frame(pins) : fill_frame(pins)
  end

  def score
    score_error_check
    score = 0
    @frames[0..9].each_with_index do |frame, index|
      score += frame.score
      next score if frame.score < 10
      score += score_spare(index) if 2 == frame.roll_count
      score += score_strike(index) if 1 == frame.roll_count
    end
    score
  end

  private

  def fill_frame(pins)
    fill_frame_error_check(pins)
    @frames.last.process_roll(pins)
    @game_over = !need_fills?
  end

  def fill_frame_error_check(pins)
    the_frame = @frames.last
    raise ERRMSG[:badpincount] if
      1 == the_frame.roll_count &&
      the_frame.rolls.first < 10 &&
      the_frame.score + pins > 10
  end

  def need_fills?
    10 == @frames[9].score &&
      (@frames[10].nil? || @frames[9].roll_count + @frames[10].roll_count < 3)
  end

  def next_frame
    @frames << Frame.new(@next_frame_num)
    @next_frame_num += 1
  end

  def process_frame(pins)
    process_frame_error_check(pins)
    the_frame = @frames.last
    the_frame.process_roll(pins)
    if tenth_frame_no_strike_or_spare?
      @game_over = true
    elsif 2 == the_frame.roll_count || 10 == the_frame.score
      next_frame
    end
  end

  def process_frame_error_check(pins)
    raise ERRMSG[:badpincount] if @frames.last.score + pins > 10
  end

  def roll_error_check(pins)
    raise ERRMSG[:gameoverroll] if @game_over
    raise ERRMSG[:badrollsize] unless pins.between?(0, 10)
  end

  def score_error_check
    raise ERRMSG[:scorebeforegame] unless @game_over
    raise ERRMSG[:scorebeforefills] if need_fills?
  end

  def score_spare(index)
    @frames[index + 1].rolls.first
  end

  def score_strike(index)
    @frames[(index + 1)..(index + 2)].map(&:rolls).flatten[0..1].sum
  end

  def tenth_frame_no_strike_or_spare?
    the_frame = @frames.last
    10 == the_frame.frame_num &&
      2 == the_frame.roll_count &&
      the_frame.score < 10
  end
end

# def roll_n_times(game, rolls, pins)
#   rolls.times do
#     Array(pins).each { |value| game.roll(value) }
#   end
# end

# game = Game.new
#     game.roll_n_times(10, 10)
#     game.roll(10)
#     # game.roll(10)
#     game.roll(3)
#     # binding.pry
# p game.score
# game.roll_n_times(18, 0)
# game.roll(10)
# game.roll(9)
# game.roll(10)
# p game.score
# game.roll(1)
# p game.score
