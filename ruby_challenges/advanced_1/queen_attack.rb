class Queens_old
  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError, "Queens can't occupy same space" if white == black
    @white = { x: white[0], y: white[1] }
    @black = { x: black[0], y: black[1] }
  end

  def attack?
    @white[:x] == @black[:x]   ||
      @white[:y] == @black[:y] ||
      @white.values.reduce(:-).abs == @black.values.reduce(:-).abs
  end

  def black
    @black.values
  end

  def to_s
    board = Array.new(8) { '_' * 8 }
    board[@white[:x]][@white[:y]] = 'W'
    board[@black[:x]][@black[:y]] = 'B'
    board.map { |l| l.gsub(/([_WB])/, '\1 ').rstrip }.join("\n")
  end

  def white
    @white.values
  end
end

class Queens
  attr_reader :white, :black

  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError, "Queens can't occupy same space" if white == black
    @white = white
    @black = black
  end

  def attack?
    @white[0] == @black[0]   ||
      @white[1] == @black[1] ||
      @white.reduce(:-).abs == @black.reduce(:-).abs
  end

  def to_s
    board = Array.new(8) { ('_ ' * 8).rstrip }
    wx, wy = *@white
    bx, by = *@black
    board[wx][wy * 2] = 'W'
    board[bx][by * 2] = 'B'
    board.join("\n")
  end
end
