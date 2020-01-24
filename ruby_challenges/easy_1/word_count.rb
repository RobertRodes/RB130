class Phrase
  def initialize(str)
    @words = str.downcase.scan(/\d+|[a-z']+/)
    @words.map! { |e| e =~ /'[a-z]+'/ ? e.gsub("'", '') : e  }
  end

  def word_count
    @words.tally
  end
end

# p Phrase.new("Don't sit in louis' big 'classroom'.").word_count