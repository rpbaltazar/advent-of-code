require 'minitest/autorun'
require './puzzle'

class PuzzleTest < Minitest::Test
  def test_part_one_example_one
    @puzzle = Puzzle.new(%w[R2 L3])
    @puzzle.solve
    assert_equal 5, @puzzle.distance
  end

  def test_part_one_example_two
    @puzzle = Puzzle.new(%w[R2 R2 R2])
    @puzzle.solve
    assert_equal 2, @puzzle.distance
  end

  def test_part_one_example_three
    @puzzle = Puzzle.new(%w[R5 L5 R5 R3])
    @puzzle.solve
    assert_equal 12, @puzzle.distance
  end

  def test_part_one_input
    input = Reader.get_instructions('input').split ', '
    @puzzle = Puzzle.new(input)
    @puzzle.solve
    assert_equal 299, @puzzle.distance
  end

  def test_part_two_example_one
    @puzzle = Puzzle.new(%w[R8 R4 R4 R8])
    @puzzle.solve
    assert_equal 4, @puzzle.double_visit_distance
  end

  def test_part_two_input
    input = Reader.get_instructions('input').split ', '
    @puzzle = Puzzle.new(input)
    @puzzle.solve
    assert_equal 181, @puzzle.double_visit_distance
  end
end
