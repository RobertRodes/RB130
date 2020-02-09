# require 'pry'
class Garden
  PLANTS = {
    'G' => :grass, 'C' => :clover, 'R' => :radishes, 'V' => :violets
  }.freeze

  STUDENTS = %w(
    Alice Bob Charlie David Eve Fred
    Ginny Harriet Ileana Joseph Kincaid Larry
  ).freeze

  def initialize(plants, students = STUDENTS)
    students = students.map(&:downcase).map(&:to_sym).sort
    plots = students.zip(create_garden(plants)).to_h
    plots.keys.each do |student|
      define_singleton_method(student) { plots.fetch(student) }
    end
  end

  private

  def create_garden(plants)
    the_garden = []
    garden_rows = plants.split("\n").map(&:chars)
    until garden_rows.first.empty?
      the_garden << garden_rows.each_with_object([]) do |row, plot|
        2.times { plot << PLANTS.fetch(row.shift) }
      end
    end
    the_garden
  end
end

# diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
# garden = Garden.new(diagram)
# p garden.alice
# p garden.larry
