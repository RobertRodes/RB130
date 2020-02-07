class Game
  def initialize
    @frames = [Frame.new(1)]
    @next_frame_num = 2
  end

  def roll(pins)
    raise RuntimeError.new('Pins must have a value from 0 to 10') unless pins.between?(0, 10)

    the_frame = @frames.last

    # raise RuntimeError.new('Pin count exceeds pins on the lane') if (the_frame.score + pins) > 10

    the_frame.process_roll(pins)
    
    return if 11 == the_frame.frame_num

    next_frame if the_frame.score == 10 || 
      the_frame.roll_count == 2
  end

  def next_frame
    @frames << Frame.new(@next_frame_num)
    @next_frame_num += 1
  end

  def score
    score = 0
    @frames[0..-2].each_with_index do |frame, index|
      score += frame.score
      if frame.score == 10 && frame.roll_count == 2
        score += @frames[index + 1].rolls.first
      elsif frame.score == 10
        score += @frames[(index + 1)..(index + 2)].map do |frame|
          frame.rolls
        end.flatten[0..1].sum
      end
    end
    score
  end
end

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



# Each Frame has a maximum of 2 rolls and a minimum of 1 roll. If the first roll knocks down 10 pins then the frame only has 1 roll. The two rolls are added together, and the second roll cannot amount to more than ten pins total for the frame. 