require 'minitest/autorun'
require_relative './solver.rb'
require 'byebug'

describe Solver do
  before do
    @solver = Solver.new
  end

  describe 'initialization' do
    it 'initializes the grid with the default values' do
      column_count = @solver.grid.length
      row_count = @solver.grid[0].length
      column_count.must_equal 1000
      row_count.must_equal 1000
      any_non_false = @solver.grid.flatten.any? { |state| state != false }
      any_non_false.must_equal false
    end
  end

  describe 'turn on' do
    it 'sets the value for coordinates to true' do
      # Initially is false
      cell_value = @solver.grid[100][100]
      cell_value.must_equal false

      # Turning on changes to true
      @solver.turn_on(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal true

      # Multiple turn on does not influence
      @solver.turn_on(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal true
    end
  end

  describe 'turn off' do
    it 'sets the value for coordinates to false' do
      # Turning on changes to true
      @solver.turn_on(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal true

      # Turning off changes to false
      @solver.turn_off(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal false

      # Multiple turn off does not influence
      @solver.turn_off(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal false
    end
  end

  describe 'toggle' do
    it 'inverts the value for coordinates' do
      # Turning on changes to true
      @solver.turn_on(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal true

      # Toggle changes to false
      @solver.toggle(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal false

      # Toggle again changes to true
      @solver.toggle(100, 100)
      cell_value = @solver.grid[100][100]
      cell_value.must_equal true
    end
  end

  describe 'extract_coordinates' do
    it 'returns an array with the coordinates in sequence [x1,y1,x2,y2]' do
      instruction1 = 'turn on 0,0 through 999,999'
      coords = @solver.extract_coordinates(instruction1)
      coords.must_equal [0, 0, 999, 999]

      instruction1 = 'toggle 0,0 through 999,0'
      coords = @solver.extract_coordinates(instruction1)
      coords.must_equal [0, 0, 999, 0]

      instruction1 = 'turn off 499,499 through 500,500'
      coords = @solver.extract_coordinates(instruction1)
      coords.must_equal [499, 499, 500, 500]
    end
  end

  describe 'extract_action' do
    it 'the action to be performed' do
      instruction1 = 'turn on 0,0 through 999,999'
      action = @solver.extract_action(instruction1)
      action.must_equal 'turn_on'

      instruction1 = 'toggle 0,0 through 999,0'
      action = @solver.extract_action(instruction1)
      action.must_equal 'toggle'

      instruction1 = 'turn off 499,499 through 500,500'
      action = @solver.extract_action(instruction1)
      action.must_equal 'turn_off'
    end
  end

  describe 'solve' do
    it 'returns the count of lights on' do
      total_on = @solver.solve('input_small')
      total_on.must_equal 998_996
    end
  end
end
