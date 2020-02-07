# require 'pry'
class Matrix
  attr_reader :rows, :columns

  def initialize(matrix)
    # @rows = matrix.split("\n").map(&:split).each { |el| el.map!(&:to_i) }
    @rows = matrix.split("\n").map(&:split).map { |el| el.map(&:to_i) }
    @columns = @rows.transpose
  end

  def saddle_points
    @rows.each_with_index.with_object([]) do |(row, row_idx), points| 
      row.each_with_index do |el, col_idx|
        points << [row_idx, col_idx] if 
          el == row.max && el == @columns[col_idx].min
      end
    end
  end
end

# m = Matrix.new("18 3 39 19 91\n38 10 8 77 320\n3 4 8 6 7")
# # p m
# p m.saddle_points

  # def saddle_points
  #   (0...@rows.size).each_with_object([]) do |r_idx, points|
  #     (0...@columns.size).each do |c_idx|
  #       points << [r_idx, c_idx] if 
  #         @rows[r_idx][c_idx] == @rows[r_idx].max &&
  #         @columns[c_idx][r_idx] == @columns[c_idx].min
  #     end
  #   end
  # end
  
