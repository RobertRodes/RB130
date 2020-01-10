class Phrase
  def initialize(str)
    @words = str.downcase.scan(/\d+|[a-z']+/)
    @words.map! { |e| e =~ /'[a-z]+'/ ? e.gsub("'", '') : e  }
  end

  def word_count
    @words.group_by(&:itself).transform_values(&:count)
  end
end

# p Phrase.new("Don't sit in louis' big 'classroom'.").word_count