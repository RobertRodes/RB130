class Cipher
  ALPHABET = [*'a'..'z'].freeze

  attr_reader :key

  def initialize(key = Array.new(100) { ALPHABET.sample }.join )
    fail ArgumentError.new('Incorrect key') if key.class != String || 
      key.empty? || key =~ /[^a-z]/

    @key = key
  end

  def encode(text)
    code(text)
  end

  def decode(text)
    code(text, -1)
  end

  private

  def code(text, decode = 1)
    text.each_char.with_index.with_object('') do |(char, i), code_text|
      key_offset = (@key[i].ord - 'a'.ord) * decode
      code_text << ALPHABET.rotate(key_offset)[ALPHABET.index(char)]
    end
  end
end
