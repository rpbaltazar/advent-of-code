require 'minitest/autorun'
require './triangle_tester'

class TriangleTesterTest < Minitest::Test
  def test_triangle_has_3_sides
    input = [5, 10, 25, 40]
    res = TriangleTester.triangle?(input)
    assert_equal false, res
  end

  def test_part_one_example_one
    input = [5, 10, 25]
    res = TriangleTester.triangle?(input)
    assert_equal false, res
  end

  def test_part_one_example_two
    input = [5, 10, 11]
    res = TriangleTester.triangle?(input)
    assert_equal true, res
  end

  def test_part_one_example_isosceles
    input = [869, 792, 792]
    res = TriangleTester.triangle?(input)
    assert_equal true, res
  end

  def test_part_one_example_equilatero
    input = [792, 792, 792]
    res = TriangleTester.triangle?(input)
    assert_equal true, res
  end
end
