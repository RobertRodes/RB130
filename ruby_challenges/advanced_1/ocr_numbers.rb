class OCR
  NUMBERS = {
    '1' => ['', '  |', '  |'],
    '2' => [' _', ' _|', '|_'],
    '3' => [' _', ' _|', ' _|'],
    '4' => ['', '|_|', '  |'],
    '5' => [' _', '|_', ' _|'],
    '6' => [' _', '|_', '|_|'],
    '7' => [' _', '  |', '  |'],
    '8' => [' _', '|_|', '|_|'],
    '9' => [' _', '|_|', ' _|'],
    '0' => [' _', '| |', '|_|']
  }.freeze

  def initialize(text)
    @text = text
  end

  def convert
    @text.split("\n\n").map { |row| read_numbers(row) }.join(',')
  end

  private

  def read_numbers(text)
    rows = text.split("\n")
    size = rows.map(&:size).max
    row_cols = rows.map { |l| l.ljust(size).chars.each_slice(3).to_a.map(&:join) }
    row_cols.transpose.map do |n| 
      number = NUMBERS.select { |_, v| v == n.map(&:rstrip) }.keys.first
      !!number ? number : '?'
    end.join
  end
end

def ocr_print(strnum)
  NUMBERS[strnum].each do |line|
    puts line
  end
end

def ocr_print2(strnum)
  3.times do |i|
    strnum.chars.each do |c|
      print NUMBERS[c][i]
    end
    print "\n"
  end
end

text = []

# text[0] = <<-NUMBER.chomp
#        _     _        _  _
#   |  || |  || |  |  || || |
#   |  ||_|  ||_|  |  ||_||_|

#     NUMBER


text[1] = <<-NUMBER.chomp
 _
| |
|_|

    NUMBER

# text[2] = <<-NUMBER.chomp
#     _
#   || |
#   ||_|

#     NUMBER

# text[3] = <<-NUMBER.chomp
#     _  _
#   | _| _|
#   ||_  _|

# NUMBER

# text[4] = <<-NUMBER.chomp
#        _     _        _  _
#   |  || |  || |  |  || || |
#   |  ||_|  ||_|  |  ||_||_|

# NUMBER

# text[5] = <<-NUMBER.chomp
#        _     _           _
#   |  || |  || |     || || |
#   |  | _|  ||_|  |  ||_||_|

# NUMBER

# text[6] = <<-NUMBER.chomp
#     _  _     _  _  _  _  _  _
#   | _| _||_||_ |_   ||_||_|| |
#   ||_  _|  | _||_|  ||_| _||_|

# NUMBER

text[0] = <<-NUMBER.chomp
    _  _
  | _| _|
  ||_  _|

    _  _
|_||_ |_
  | _||_|

 _  _  _
  ||_||_|
  ||_| _|

NUMBER

text.each { |t| p OCR.new(t).convert }

# ocr_print2('1234567890')

# ('0'..'9').each { |c| ocr_print(c) }

#   _  _     _  _  _  _  _  _
# | _| _||_||_ |_   ||_||_|| |
# ||_  _|  | _||_|  ||_| _||_|
