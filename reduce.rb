def reduce2(arr, acc = nil)
  counter = acc.nil? ? 1 : 0
  acc ||= arr[0]
  loop do
    acc = yield(acc, arr[counter])
    counter += 1
    break if counter == arr.size
  end
  acc
end

def reduce(arr, acc = nil)
  if acc.nil?
    counter = 1
    acc = arr[0]
  else counter = 0
  end
  loop do
    acc = yield(acc, arr[counter])
    counter += 1
    break if counter == arr.size
  end
  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
p reduce([true, true, true], false) { |acc, value| acc && value }