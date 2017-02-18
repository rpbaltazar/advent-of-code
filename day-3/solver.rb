require_relative '../utils/reader'

def at_least_one
  elf_instructions = Reader.get_instructions 'input'
  visited_mem = {}
  x, y = 0, 0

  visited_mem[x][y] = 1
  total_count = 1

  elf_instructions.split('').each do |char|
    case char
    when '^'
      x += 1
    when '>'
      y += 1
    when 'v'
      x -= 1
    when '<'
      y -= 1
    end

    if visited_mem[x].nil?
      visited_mem[x] = {}
      visited_mem[x][y] = 1
      total_count+=1
    elsif visited_mem[x][y].nil?
      visited_mem[x][y] = 1
      total_count+=1
    else
      visited_mem[x][y] += 1
    end
  end

  return total_count
end

def get_postion_changes char
  case char
  when '^'
    {x: 1, y: 0}
  when '>'
    {x: 0, y: 1}
  when 'v'
    {x: -1, y: 0}
  when '<'
    {x: 0, y: -1}
  end
end

def santa_and_robot
  elf_instructions = Reader.get_instructions 'input'

  visited_mem = {}
  santa_x, santa_y = 0, 0
  robot_x, robot_y = 0, 0
  santa_turn = true

  visited_mem[santa_x] = {}
  visited_mem[santa_x][santa_y] = 2
  total_count = 1

  elf_instructions.split('').each do |char|
    change = get_postion_changes char

    if santa_turn
      santa_x += change[:x]
      santa_y += change[:y]

      x = santa_x
      y = santa_y
    else
      robot_x += change[:x]
      robot_y += change[:y]

      x = robot_x
      y = robot_y
    end

    if visited_mem[x].nil?
      visited_mem[x] = {}
      visited_mem[x][y] = 1
      total_count+=1
    elsif visited_mem[x][y].nil?
      visited_mem[x][y] = 1
      total_count+=1
    else
      visited_mem[x][y] += 1
    end

    santa_turn = !santa_turn
  end

  return total_count
end

puts at_least_one
puts santa_and_robot
