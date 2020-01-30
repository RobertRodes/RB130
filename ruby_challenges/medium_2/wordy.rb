# require 'pry'
class WordProblem
  OPERATORS = {
    'plus' => '+',
    'minus' => '-',
    'multiplied by' => '*',
    'divided by' => '/',
  }

  def initialize(question)
    # binding.pry
    @question = question.match(/-?\d+.+-?\d+/).to_s
    check = Regexp.new(/-?\d* (multiplied by|divided by|minus|plus) -?\d+/)
    fail ArgumentError.new('Invalid question') unless @question.match(check)
  end

  def answer
    q = @question.gsub!(/(-?\d+[^\d]+-?\d+)/, '(\1)')
    eval(dewordify(q))
  end

  def answer_extra
    eval(dewordify(@question))
  end

  def dewordify(str)
    str.gsub(/[a-z ]+/) do |operator|
      OPERATORS[operator.strip]
    end
  end
end

# p WordProblem.new('What is 7 plus 2 multiplied by 9?').answer
# p WordProblem.new('What is 7 minus 10?').answer_extra
# p WordProblem.new('What is 7 cubed 3?').answer_extra
# p WordProblem.new('Whazzup?').answer_extra