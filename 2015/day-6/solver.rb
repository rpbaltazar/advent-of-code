# grid = [][]
# use true/false for current state of the grid cell
# (each grid cell represents a light)

# For Part 2, changes needed:
# - brightness counter - replace the 'false' initialization with '0'
# - update turn on method to add 1 to brightness counter
# - update turn off method to reduce 1 to brightness counter. minimum is 0
# - update toggle method to add 2 to brightness counter
class Solver
  attr_reader :grid

  def initialize
    # setup the data with initial values
    @grid = Array.new(1000) { Array.new(1000, false) }
  end

  def solve(input_name)
    File.foreach(input_name) do |instruction|
      action = extract_action instruction
      coordinates = extract_coordinates instruction
      run_action(action, *coordinates)
    end
    grid.flatten.count(true)
  end

  def turn_on(x, y)
    grid[x][y] = true
  end

  def toggle(x, y)
    if grid[x][y] == true
      grid[x][y] = false
    elsif grid[x][y] == false
      grid[x][y] = true
    end
  end

  def turn_off(x, y)
    grid[x][y] = false
  end

  def extract_coordinates(instruction)
    instruction.scan(/\d+/).map(&:to_i)
  end

  def extract_action(instruction)
    # solution 1: case/when
    # solution 2: if/else
    # There is only one match for sure, so we can safely return index 0
    action_str = instruction.scan(/turn on|turn off|toggle/)[0]
    action_str.tr(' ', '_')
  end

  private

  def run_action(action, x1, y1, x2, y2)
    (x1..x2).each do |temp_x|
      (y1..y2).each do |temp_y|
        send(action, temp_x, temp_y)
      end
    end
  end
end

solver = Solver.new
solver.solve('input_small')
