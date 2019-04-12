require 'minitest/autorun'
require './puzzle'

class PuzzleTest < Minitest::Test
  # TODO: Might be useful to move this to the utils class
  def squish(string)
    string.strip!
    string.gsub!(/\s+/, ' ')
    string
  end

  def test_possible_triangles
    input = [
      [5, 10, 25, 40],
      [5, 10, 25],
      [5, 10, 11]
    ]
    @puzzle = Puzzle.new(input)
    @puzzle.solve_horizontal
    assert_equal 1, @puzzle.solution
  end

  def test_part_one_input
    lines = File.readlines('input')
    input = lines.map { |line| squish(line).split(' ').map(&:to_i) }
    @puzzle = Puzzle.new(input)
    @puzzle.solve_horizontal
    # puts @puzzle.solution
    assert_equal 982, @puzzle.solution
  end

  def test_part_two_example
    input = [
      [101, 301, 501],
      [102, 302, 502],
      [103, 303, 503],
      [201, 401, 601],
      [202, 402, 602],
      [203, 403, 603]
    ]
    @puzzle = Puzzle.new(input)
    @puzzle.solve_vertical
    # puts @puzzle.solution
    assert_equal 6, @puzzle.solution
  end

  def test_part_two_input
    lines = File.readlines('input')
    input = lines.map { |line| squish(line).split(' ').map(&:to_i) }
    @puzzle = Puzzle.new(input)
    @puzzle.solve_vertical
    # puts @puzzle.solution
    assert_equal 1826, @puzzle.solution
  end
end
