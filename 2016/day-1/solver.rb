require 'ostruct'

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
  ROTATION = {
    'R' => 1,
    'L' => -1
  }.freeze

  DIRECTIONS = OpenStruct.new(
    NORTH: 0,
    EAST: 1,
    SOUTH: 2,
    WEST: 3
  ).freeze

  def initialize(input)
    @input = input
    @facing = DIRECTIONS.NORTH
    @pos_x = 0
    @pos_y = 0
    @visited = { 0 => { 0 => true } }
    @double_visits = []
  end

  def solve
    @input.each do |instruction|
      direction = instruction[0]
      quantity = instruction[1..-1].to_i
      turn(direction)
      visit(quantity)
    end
  end

  def distance
    @pos_x.abs + @pos_y.abs
  end

  def double_visit_distance
    @double_visits[0][:x].abs + @double_visits[0][:y].abs
  end

  private

  def turn(direction)
    @facing = (@facing + ROTATION[direction]) % 4
  end

  def visit(quantity)
    old_pos_x = @pos_x
    old_pos_y = @pos_y

    case @facing
    when DIRECTIONS.NORTH
      @pos_y += quantity
      range = Range.new(old_pos_y + 1, @pos_y)
      range.each { |y| visit_node(@pos_x, y) }
    when DIRECTIONS.SOUTH
      @pos_y -= quantity
      range = Range.new(@pos_y, old_pos_y - 1)
      range.each { |y| visit_node(@pos_x, y) }
    when DIRECTIONS.EAST
      @pos_x += quantity
      range = Range.new(old_pos_x + 1, @pos_x)
      range.each { |x| visit_node(x, @pos_y) }
    when DIRECTIONS.WEST
      @pos_x -= quantity
      range = Range.new(@pos_x, old_pos_x - 1)
      range.each { |x| visit_node(x, @pos_y) }
    end
  end



  def visit_node(pos_x, pos_y)
    @visited[pos_x] ||= {}
    @double_visits << { x: pos_x, y: pos_y } if @visited[pos_x][pos_y]
    @visited[pos_x][pos_y] = true
  end
end
