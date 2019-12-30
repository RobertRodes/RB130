# def gather(items)
#   yield(items)
# end

def birds(ary)
  yield(ary)
end

# gather(['apples', 'corn', 'cabbage', 'wheat']) do |items|
#   puts "Let's start gathering food."
#   puts "#{items.join(', ')}"
#   puts "Nice selection of food we have gathered!"
# end

# birds(%w(crow finch hawk eagle)) { |_, _, *raptors| p raptors }

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# gather(items) do |*items, last_item |
#   puts "#{items.join(', ')}"
#   puts last_item
# end

# gather(items) do |first_item, *items, last_item |
#   puts first_item
#   puts "#{items.join(', ')}"
#   puts last_item
# end

# gather(items) do |first_item, *items|
#   puts first_item
#   puts "#{items.join(', ')}"
# end

gather(items) do |item1, item2, item3, item4|
  puts "#{[item1, item2, item3].join(', ')}, and #{item4}"
end

gather(items) do |items|
  puts "#{items[0..-2].join(', ')}, and #{items.last}"
end
