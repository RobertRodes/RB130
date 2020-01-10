# require 'pry'
class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(words)
    words.select do |word|
      word.downcase != @word && 
      word.downcase.chars.sort == @word.chars.sort
    end
  end
end

