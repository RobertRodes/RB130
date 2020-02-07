class RailFenceCipher
  @direction = :+
  @row_size = nil

  class << self
    def encode(plaintext, row_size)
      return plaintext if 1 == row_size
      @row_size = row_size
      fencify(plaintext).map(&:compact).map(&:join).join
    end

    def decode(ciphertext, row_size)
      return ciphertext if 1 == row_size
      @row_size = row_size
      encrypted_fence = fencify(ciphertext)
      plaintext_fence = decrypt_fence(encrypted_fence, ciphertext)
      parse_fence(plaintext_fence)
    end

    private

    # Plug encrypted text into fence, left to right and top to bottom
    def decrypt_fence(encrypted_fence, coded_text)
      current_char = 0
      encrypted_fence.each_with_index do |row, _i|
        row.each_with_index do |char, j|
          next if char.nil?
          row[j] = coded_text[current_char]
          current_char += 1
        end
      end
    end

    # Arrange input text in fence format
    def fencify(text)
      fence = []
      @row_size.times { fence << [] }

      current_row = 0
      current_char = 0

      text.size.times do
        fence.each.with_index do |ary, i|
          if i == current_row && text[current_char]
            ary << text[current_char]
            current_char += 1
          else ary << nil
          end
        end

        current_row = next_row(current_row)
      end
      fence
    end

    # Zigzag pointer
    def next_row(current_row)
      next_row = current_row.send(@direction, 1)
      unless (0...@row_size).cover?(next_row)
        @direction = @direction == :+ ? :- : :+
        next_row = next_row.send(@direction, 2)
      end
      next_row
    end

    # Read the decrypted fence along the zigzag to get plaintext
    def parse_fence(decrypted_fence)
      row_enums = []
      decrypted_fence.each { |row| row_enums << row.compact.to_enum }
      plaintext = ''
      current_row = 0
      loop do
        plaintext += row_enums[current_row].next
        current_row = next_row(current_row)
      end
      plaintext
    end
  end
end

# RailFenceCipher.encode('THEDEVILISINTHEDETAILS', 3) #'WECRLTEERDSOEEFEAOCAIVDEN'
# p RailFenceCipher.decode('TEITELHDVLSNHDTISEIIEA', 3) #.each { |r| p r }
