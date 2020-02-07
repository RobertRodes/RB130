class Robot
  COMPASS_POINTS = %i(north east south west).freeze
  ADVANCE_X = [0, 1, 0, -1].freeze
  ADVANCE_Y = [1, 0, -1, 0].freeze

  def initialize
    @x = 0
    @y = 0
    @direction = 0
  end

  def advance
    @x += ADVANCE_X[@direction]
    @y += ADVANCE_Y[@direction]
  end

  def at(x, y)
    @x, @y = x, y
  end

  def bearing
    COMPASS_POINTS[@direction]
  end

  def coordinates
    [@x, @y]
  end

  def orient(compass_point)
    raise ArgumentError, 'Invalid compass point value' unless
      COMPASS_POINTS.include?(compass_point)
    @direction = COMPASS_POINTS.index(compass_point)
  end

  def turn_left
    turn :-
  end

  def turn_right
    turn :+
  end

  private

  def turn(way)
    @direction = @direction.send(way, 1) % 4
  end
end

class Simulator
  MOVE_METHODS = {
    'R' => :turn_right, 'L' => :turn_left, 'A' => :advance
  }.freeze

  def evaluate(robot, input)
    instructions(input).each { |instr| robot.send(instr) }
  end

  def instructions(input)
    input.chars.map { |c, ary| MOVE_METHODS.fetch(c) }
  end

  def place(robot, x: 0, y: 0, direction: :north)
    robot.at(x, y)
    robot.orient(direction)
  end
end
