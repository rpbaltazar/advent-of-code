def which_floor
  instructions = get_instructions
  up_one = instructions.scan(/\(/).size
  down_one = instructions.scan(/\)/).size

  puts "#{up_one} - #{down_one} = #{up_one - down_one}"
end

def which_char
  instructions = get_instructions
  floor = 0
  instructions.split('').each_with_index do |char, index|
    if char == '('
      floor += 1
    else
      floor -= 1
    end

    if floor < 0
      puts "#{index + 1}"
      return index+1
    end
  end
  return -1
end

def get_instructions
  whole_file = File.readlines 'input'
  whole_file[0]
end


# which_floor
which_char
