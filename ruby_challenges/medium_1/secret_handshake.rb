class SecretHandshake
  MOVES = {
    1 => 'wink',
    10 => 'double blink',
    100 => 'close your eyes',
    1000 => 'jump'
  }.freeze

  def initialize(code)
    @code = code.is_a?(Integer) ? code.to_s(2) : code.to_i.to_s(2)
  end

  def commands
    result = []
    @code.reverse.each_char.with_index do |c, i|
      break if 4 == i
      result << MOVES[10**i] if '1' == c
    end
    @code.size == 5 ? result.reverse : result
  end
end

p SecretHandshake.new('42').commands
