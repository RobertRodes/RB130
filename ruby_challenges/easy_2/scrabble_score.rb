class Scrabble
  SCORES = {
    1 => %w(A E I O U L N R S T),
    2 => %w(D G),
    3 => %w(B C M P),
    4 => %w(F H V W Y),
    5 => %w(K),
    8 => %w(J X),
    10 => %w(Q Z)
  }.freeze

  def initialize(word)
    @word = word || ''
  end

  def self.score(word)
    score = 0
    word.upcase.each_char do |char|
      SCORES.each do |key, value|
        if value.index(char)
          score += key
          break
        end
      end
    end
    score
  end

  def score
    Scrabble.score(@word)
  end
end
