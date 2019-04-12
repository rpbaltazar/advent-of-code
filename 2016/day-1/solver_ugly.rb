class Solver
  require_relative '../../utils/reader'
  def initialize
    @input = Reader.get_instructions('input').split ', '
  end

  def solve
    puzzle = Puzzle.new(@input)
    puzzle.solve
  end
end

class Puzzle
  def initialize(input)
    @face = 'n'
    @west_east = 0
    @south_north = 0
    @visited = { 0 => { 0 => 1 } }
    @input = input
  end

  def solve
    @input.each do |instruction|
      direction = instruction[0]
      quantity = instruction[1..-1].to_i
      case @face
      when 'n'
        if direction == 'R'
          (@west_east + 1..@west_east + quantity).each do |val|
            visit_node(val, @south_north)
          end
          @west_east += quantity
          @face = 'e'
        else
          (@west_east - quantity..@west_east - 1).each do |val|
            visit_node(val, @south_north)
          end
          @west_east -= quantity
          @face = 'w'
        end
      when 's'
        if direction == 'R'
          (@west_east - quantity..@west_east - 1).each do |val|
            visit_node(val, @south_north)
          end
          @west_east -= quantity
          @face = 'w'
        else
          (@west_east + 1..@west_east + quantity).each do |val|
            visit_node(val, @south_north)
          end
          @west_east += quantity
          @face = 'e'
        end
      when 'e'
        if direction == 'R'
          (@south_north - quantity..@south_north - 1).each do |val|
            visit_node(@west_east, val)
          end
          @south_north -= quantity
          @face = 's'
        else
          (@south_north + 1..@south_north + quantity).each do |val|
            visit_node(@west_east, val)
          end

          @south_north += quantity
          @face = 'n'
        end
      when 'w'
        if direction == 'R'
          (@south_north + 1..@south_north + quantity).each do |val|
            visit_node(@west_east, val)
          end

          @south_north += quantity
          @face = 'n'
        else
          (@south_north - quantity..@south_north - 1).each do |val|
            visit_node(@west_east, val)
          end

          @south_north -= quantity
          @face = 's'
        end
      end
    end
  end

  def distance
    @south_north.abs + @west_east.abs
  end

  def double_visit_distance
    @first_double_visit[:x].abs + @first_double_visit[:y].abs
  end

  private

  def visit_node(x, y)
    @visited[x] ||= {}
    @first_double_visit = { x: x, y: y } if !@first_double_visit && @visited[x][y]
    @visited[x][y] = 1
  end
end
