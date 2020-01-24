# def print_forwards(str)
#   str.size.times do |i|
#     print str[i]
#   end
# end

# def print_backwards(str)
#   -1.downto(-str.size) do |num|
#     print str[num]
#   end
# end

def odd_words_reversed(str)
  raise 'Input may not be empty' if str.empty?
  if str.match(/[a-z ]+\./).to_s != str
    raise 'Input must contain only letters and spaces, " \
      "with one and only one period at the end'
  end

  str[0..-2].split.map.with_index do |w, i|
    i.odd? ? w.reverse : w
  end.join(' ') + '.'
end

# def odd_words_reversed_bonus(str)
#   s = str[0..-2].split
#   s.each_with_index do |w, i|
#     i.even? ? print_backwards(w) : print_forwards(w)
#     print ' ' unless i == s.size - 1
#   end
#   print ".\n"
# end

def print_reverse(str, start_index, end_index)
  while start_index > end_index
    next if str[start_index] == '.'
    print str[start_index]
    start_index -= 1
  end
end

def odd_words_reversed_bonus(str)
  raise 'Input may not be empty.' if str.empty?
  if str.match(/[a-z ]+\./).to_s != str
    raise 'Input must contain only letters and spaces, " \
      "with one and only one period at the end.'
  end
  space_count = 1               # used to check odd and even words
  last_space_index = -1         # print back to this index when printing in reverse
  prev_char_was_space = false   # used to ignore multiple spaces
  index = -1                    # need to increment index at beginning because of 'next'
  while index < str.size - 1    # in prev_char_was_space check
    index += 1
    if ' ' == str[index]
      if prev_char_was_space    # then ignore it
        last_space_index = index
        next
      end
      print_reverse(str, index - 1, last_space_index) if space_count.even?
      space_count += 1
      last_space_index = index
      prev_char_was_space = true
    else
      next if str[index] == '.'
      if prev_char_was_space
        print ' '
        prev_char_was_space = false
      end
      print str[index] if space_count.odd?
    end
  end
  print_reverse(str, index - 1, last_space_index) if space_count.even?
  print ".\n"
  nil
end

# odd_words_reversed_bonus('every good   . boy does     .')
