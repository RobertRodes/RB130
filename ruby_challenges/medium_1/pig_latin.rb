class PigLatin
  def self.translate(str)
    str.split.map { |word| translate_word(word) }.join(' ')
  end

  def self.translate_word(word)
    cut_index = word =~ /[aeio]|(?<!q)u|[xy][^aeiou]/
    return word + 'ay' if cut_index.zero?
    word[cut_index..-1] + word[0..cut_index - 1] + 'ay'
  end
end

puts PigLatin.translate('ear')