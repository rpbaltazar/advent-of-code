class TriangleTester
  def self.triangle?(sides = [])
    return false unless sides.length == 3

    combinations = sides.combination(2).to_a
    combinations.all? do |test_case|
      remaining_value = sides - test_case
      next true if remaining_value.empty?

      test_case[0] + test_case[1] > remaining_value[0]
    end
  end
end
