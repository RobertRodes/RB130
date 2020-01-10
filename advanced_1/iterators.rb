fib = Enumerator.new do |y|
  a = b = 1
  loop do
    y << a
    a, b = b, a + b
  end
end

fact = Enumerator.new do |y|
  a = 1
  inc = 0
  loop do
    inc += 1
    y.yield(a)
    a *= inc    
  end
end

res = []
15.times do |idx|
  res << [fib.next, fact.next]
  fact.rewind if ((idx + 1) % 5).zero?
end

p res
p fib.take(10) 

def factorial(how_many)
  fact = Enumerator.new do |y|
    a = 1
    inc = 0
    loop do
      inc += 1
      y.<<(a)
      a *= inc    
    end
  end
  fact.take(how_many)
end

puts factorial(7)

fact = Enumerator.new do |y|
  a = 1
  inc = 0
  loop do
    inc += 1
    y.yield(a)
    a *= inc    
  end
end
