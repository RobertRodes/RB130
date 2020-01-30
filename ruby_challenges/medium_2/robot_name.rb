class Robot
  attr_reader :name

  def initialize
    reset
  end

  def reset
    @name = new_name
  end

  private

  def new_name
    Kernel.srand
    new_name = ''
    2.times { new_name << ('A'..'Z').to_a.sample }
    3.times { new_name << ('0'..'9').to_a.sample }
    new_name
  end
end

# class Robot
#   class << self; attr_accessor :names; end

#   attr_reader :name

#   Robot.names = []

#   def initialize
#     reset
#   end

#   def reset
#     @name = ''
#     2.times { @name << [*('A'..'Z')].sample }
#     3.times { @name << [*('0'..'9')].sample }
#     Robot.names.include?(@name) ? reset : Robot.names << @name
#   end
# end

x = 5
5.times do
  Kernel.srand(x - 1)
  p Robot.new.name
end

# p Robot.new.name