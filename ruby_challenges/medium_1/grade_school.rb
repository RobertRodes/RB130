class School
  def initialize
    @students = Hash.new { |hash, key| hash[key] = [] }
  end

  def add(name, grade)
    @students[grade] << name
  end

  def grade(grade)
    @students[grade]
  end

  def to_h
    @students.sort.map { |k, v| [k, v.sort] }.to_h
  end
end

school = School.new
[
  ['Jennifer', 4], ['Kareem', 6],
  ['Christopher', 4], ['Kyle', 3]
].each do |name, grade|
  school.add(name, grade)
end

p school.to_h
p school.grade(4)
p school.grade(7)