class TextAnalyzer
  def process
    yield(File.read('test.txt'))
  end
end

analyzer = TextAnalyzer.new

analyzer.process do |text| 
  text = text.gsub('  ', ' ') while text =~ /  /
  text = text.gsub("\n ", "\n")
  puts "#{text.split("\n\n").count} paragraphs" 
end

analyzer.process { |text| puts "#{text.split("\n").count} lines" }

analyzer.process do |text|
  text = text.split("\n").join(' ')
  text = text.gsub('  ', ' ') while text =~ /  /
  puts "#{text.split(' ').count} words"
end

# test.txt

# Lorem ipsum dolor sit amet,
# consectetur adipiscing elit,
# sed eiusmod. 

# Tempor incididunt labore et dolore.