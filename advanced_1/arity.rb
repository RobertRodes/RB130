# # Group 1
# my_proc = proc { |thing| puts "This is a #{thing}." }
# puts my_proc
# puts my_proc.class
# my_proc.call
# my_proc.call('cat')

# # Group 2
# my_lambda = lambda { |thing| puts "This is a #{thing}." }
# my_second_lambda = -> (thing) { puts "This is a #{thing}." }
# puts my_lambda
# puts my_second_lambda
# puts my_lambda.class
# my_lambda.call('dog')
# my_lambda.call('wombat')
# my_third_lambda = Kernel.lambda { |thing| puts "This is a #{thing}." }

# # Group 3
# def block_method_1(animal)
#   yield if block_given?
# end

# block_method_1('seal') { |seal| puts "This is a #{seal}."}
# # block_method_1('seal')

# # Group 4
# def block_method_2(animal)
#   yield(animal)
# end

# block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
# block_method_2('turtle') do |turtle, seal|
#   puts "This is a #{turtle} and a #{seal}."
# end
# block_method_2('turtle') { puts "This is a #{animal}."}

def proc_method(ary)
  my_proc = proc do |str|
    puts str
  end
  my_proc.call(ary.join)
  test(&my_proc)
end

def test(&test_block)
  test_block.yield('hello from test')
end

def lambda_method(ary)
  test = 'test'
  my_lambda = -> (ary) do
    ary.each { |el| return if el == 'bar'}
  end
  my_lambda.call(ary)
  puts 'Hello from lambda_method'
end

proc_method(%w(foo bar))
lambda_method(%w(foo bar))
