class Crypto
  attr_reader :normalize_plaintext, :size, :plaintext_segments

  def initialize(plaintext)
    @normalize_plaintext = plaintext.downcase.scan(/[a-z\d]/).join
    @size = Math.sqrt(@normalize_plaintext.size).ceil
    @plaintext_segments = @normalize_plaintext.scan(/.{1,#{@size}}/)
    @ciphertext_segments = ciphertext_segments
  end

  def ciphertext
    @ciphertext_segments.join
  end

  def normalize_ciphertext
    @ciphertext_segments.join(' ')
  end

  private

  def ciphertext_segments
    the_chars = @plaintext_segments.map(&:chars)
    the_chars[-1] << '' while the_chars[-1].size < @size
    the_chars.transpose.map(&:join)
  end    
end


# x = Crypto.new('If man was meant to stay on the ground god would have given us roots')
# puts x.normalize_ciphertext
# puts
# puts x.plaintext_segments
# puts x.size