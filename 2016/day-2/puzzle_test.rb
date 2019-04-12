require 'minitest/autorun'
require './puzzle'

class PuzzleTest < Minitest::Test
  def test_part_one_example_one
    input = [
      ['U', 'L', 'L'],
      ['R', 'R', 'D', 'D', 'D'],
      ['L', 'U', 'R', 'D', 'L'],
      ['U', 'U', 'U', 'U', 'D']
    ]
    @puzzle = Puzzle.new(input)
    @puzzle.solve_normal
    assert_equal '1985', @puzzle.code
  end

  def test_part_one_input
    lines = File.readlines('input')
    input = lines.map { |line| line.split('') }
    @puzzle = Puzzle.new(input)
    @puzzle.solve_normal
    # puts @puzzle.code
    assert_equal '82958', @puzzle.code
  end

  def test_part_two_example_one
    input = [
      ['U', 'L', 'L'],
      ['R', 'R', 'D', 'D', 'D'],
      ['L', 'U', 'R', 'D', 'L'],
      ['U', 'U', 'U', 'U', 'D']
    ]

    @puzzle = Puzzle.new(input)
    @puzzle.solve_diagonal
    assert_equal '5DB3', @puzzle.code
  end

  def test_part_two_input
    lines = File.readlines('input')
    input = lines.map { |line| line.split('') }
    @puzzle = Puzzle.new(input)
    @puzzle.solve_diagonal
    # puts @puzzle.code
    assert_equal 'B3DB8', @puzzle.code
  end
end
