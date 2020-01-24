class BeerSong
  def initialize
    @bottle_text = %w(bottle bottles bottles)
    @take_text = [
      'Take it down and pass it around',
      'Take one down and pass it around',
      'Go to the store and buy some more'
    ]
  end

  def verse(num)
    bottle1 = @bottle_text[num <=> 1]
    bottle2 = @bottle_text[num - 1 <=> 1]
    num1 = ['no more', num.to_s, nil][num <=> 0]
    num2 = ['no more', (num - 1).to_s, '99'][num - 1 <=> 0]
    take1 = @take_text[num <=> 1]

    begin
      "#{num1.capitalize} #{bottle1} of beer on the wall, " \
      "#{num1} #{bottle1} of beer.\n" \
      "#{take1}, #{num2} #{bottle2} of beer on the wall.\n"
    rescue NoMethodError
      raise "Number can't be less than 0."
    end
  end

  def verses(num1, num2)
    num1.downto(num2).with_object('') do |num, str|
      str << verse(num) << "\n"
    end.chomp
  end

  def lyrics
    verses(99, 0)
  end
end

print BeerSong.new.verses(3, -1)
