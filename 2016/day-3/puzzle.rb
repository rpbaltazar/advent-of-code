require './triangle_tester'

# Puzzle initializes with an array of arrays with triangles sizes
class Puzzle
  def initialize(input)
    @input = input
    @possible_triangles = 0
  end

  def solve_vertical
    columns = @input[0].length
    (0...columns).each do |col_idx|
      arr = @input.map { |row| row[col_idx] }
      arr_idx = 0
      while arr_idx < arr.length - 1
        add_to_count([arr[arr_idx], arr[arr_idx + 1], arr[arr_idx + 2]])
        arr_idx += 3
      end
    end
  end

  def solve_horizontal
    @input.each do |triangle_sizes|
      add_to_count(triangle_sizes)
    end
  end

  def add_to_count(triangle_sizes)
    return unless TriangleTester.triangle?(triangle_sizes)

    @possible_triangles += 1
  end

  def solution
    @possible_triangles
  end
end
