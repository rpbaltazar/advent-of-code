class Keypad
  def initialize
    @max_x = 0
    @max_y = 0
    @keypad = [[]]
  end

  def finger_on
    @keypad[@pos_y][@pos_x]
  end

  def navigate(instruction)
    case instruction
    when 'U'
      @pos_y -= 1 if has_key_at?(@pos_y - 1, @pos_x)
    when 'D'
      @pos_y += 1 if has_key_at?(@pos_y + 1, @pos_x)
    when 'R'
      @pos_x += 1 if has_key_at?(@pos_y, @pos_x + 1)
    when 'L'
      @pos_x -= 1 if has_key_at?(@pos_y, @pos_x - 1)
    end
  end

  private

  def pos_x_range
    @pos_x_range ||= (0..@max_x)
  end

  def pos_y_range
    @pos_y_range ||= (0..@max_y)
  end

  def has_key_at?(pos_x, pos_y)
    return false unless pos_x_range.include?(pos_x) && pos_y_range.include?(pos_y)

    !@keypad[pos_y][pos_x].nil?
  end
end

class NormalKeypad < Keypad
  def initialize
    @max_x = @max_y = 2
    @keypad = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9']
    ]
    @pos_x = 1
    @pos_y = 1
  end
end

class DiagonalKeypad < Keypad
  def initialize
    @max_x = @max_y = 4
    @keypad = [
      [nil, nil, '1', nil, nil],
      [nil, '2', '3', '4', nil],
      ['5', '6', '7', '8', '9'],
      [nil, 'A', 'B', 'C', nil],
      [nil, nil, 'D', nil, nil]
    ]
    @pos_x = 0
    @pos_y = 2
  end
end

class Puzzle
  attr_reader :code

  def initialize(input)
    @input = input
    @code = ''
  end

  def solve
    @input.each do |digit_code|
      digit_code.each do |instruction|
        @keypad_to_use.navigate(instruction)
      end
      @code += @keypad_to_use.finger_on
    end
  end

  def solve_normal
    @keypad_to_use = NormalKeypad.new
    solve
  end

  def solve_diagonal
    @keypad_to_use = DiagonalKeypad.new
    solve
  end
end
