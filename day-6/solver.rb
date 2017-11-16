require_relative '../utils/reader'
require 'byebug'

def get_instruction(str)
  coordinates = str.scan(/\d+,\d+/)
  non_instruction = coordinates.join(' through ')
  instruction = str.gsub non_instruction, ''
  {
    instruction: instruction.strip,
    coordinates: coordinates
  }
end

def fetch_coordinates(coordinates)
  start_xy, end_xy = coordinates
  x1, y1 = start_xy.split(',').map(&:to_i)
  x2, y2 = end_xy.split(',').map(&:to_i)
  {
    start_x: x1,
    start_y: y1,
    end_x: x2,
    end_y: y2
  }
end

def turn_on1(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] = true
    end
  end
end

def turn_off1(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] = false
    end
  end
end

def toggle1(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] = !@lights_on[x][y]
    end
  end
end

def turn_on2(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] ||= 0
      @lights_on[x][y] += 1
    end
  end
end

def turn_off2(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] ||= 0
      @lights_on[x][y] -= 1
      @lights_on[x][y] = 0 if @lights_on[x][y].negative?
    end
  end
end

def toggle2(coordinates)
  lights_coords = fetch_coordinates coordinates
  (lights_coords[:start_x]..lights_coords[:end_x]).each do |x|
    (lights_coords[:start_y]..lights_coords[:end_y]).each do |y|
      @lights_on[x] ||= {}
      @lights_on[x][y] ||= 0
      @lights_on[x][y] += 2
    end
  end
end

def result1
  count = 0
  @lights_on.each do |_x, ys|
    count += ys.select { |_y, on| on }.length
  end
  count
end

def result2
  count = 0
  @lights_on.each do |_x, ys|
    ys.each { |_y, val| count += val }
  end
  count
end

def init(part)
  @lights_on = {}
  File.open('input').each do |string|
    set = get_instruction string
    method = set[:instruction].tr(' ', '_')
    send("#{method}#{part}", set[:coordinates])
    # when 'turn on'
    #   turn_on set[:coordinates]
    # when 'turn off'
    #   turn_off set[:coordinates]
    # when 'toggle'
    #   toggle set[:coordinates]
    # end
  end

  puts send("result#{part}")
end

init(1)
init(2)
