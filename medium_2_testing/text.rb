class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end

# file = File.open('sample.txt')
# text_from_file = file.read
# text = Text.new(text_from_file)
# p text.swap('a', 'Z')