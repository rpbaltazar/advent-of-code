require 'byebug'

# NOTE: Monkeypatch String object to test if its an integer
class String
  def integer?
    to_i.to_s == self
  end
end

MAGIC_REGEX = /(AND)|(OR)|(NOT)|(LSHIFT)|(RSHIFT)|->| /

def signal_for(identifier)
  regex = Regexp.new("-> #{identifier}\n")
  instruction = @whole_system.find { |row| !regex.match(row).nil? }
  parsed = parse_instruction instruction
  compute_value parsed
end

def compute_value(parsed)
#  debugger
  case parsed.length
  when 4
    # id AND/OR/LSHIFT/RSHIFT id -> res
    # number AND/OR/LSHIFT/RSHIFT number -> res
    # id AND/OR/LSHIFT/RSHIFT number -> res
    # number AND/OR/LSHIFT/RSHIFT id -> res
    id1 = parsed[0]
    operation = "#{parsed[1]}_operation".downcase
    id2 = parsed[2]
    res = parsed[3]
    if id1.integer?
      if id2.integer?
        @signals[res] = send(operation, id1, id2)
      else
        @signals[id2] = signal_for(id2) unless @signals[id2]
        @signals[res] = send(operation, id1, @signals[id2])
      end
    else
      if id2.integer?
        @signals[id1] = signal_for(id1) unless @signals[id1]
        @signals[res] = send(operation, @signals[id1], id2)
      else
        @signals[id1] = signal_for(id1) unless @signals[id1]
        @signals[id2] = signal_for(id2) unless @signals[id2]
        @signals[res] = send(operation, @signals[id1], @signals[id2])
      end
    end
  when 3
    # NOT id -> res
    # NOT number -> res
    id = parsed[1]
    res = parsed[2]
    if id.integer?
      @signals[res] = not_operation(id)
    else
      @signals[id] = signal_for(id) unless @signals[id]
      @signals[res] = not_operation(@signals[id])
    end
  when 2
    # id -> res
    # number -> res
    id = parsed[0]
    res = parsed[1]
    if id.integer?
      @signals[res] = id.to_i
    else
      @signals[id] = signal_for(id) unless @signals[id]
      @signals[res] = @signals[id]
    end
  else
    puts 'wrong parsing'
  end
end

def parse_instruction(instruction)
  instruction.split(MAGIC_REGEX) - ['']
end

def not_operation(value)
  temp_val = ~value.to_i
  return temp_val if temp_val.positive?
  65_536 + temp_val
end

def and_operation(value1, value2)
  value1.to_i & value2.to_i
end

def or_operation(value1, value2)
  value1.to_i | value2.to_i
end

def lshift_operation(value1, value2)
  value1.to_i << value2.to_i
end

def rshift_operation(value1, value2)
  value1.to_i >> value2.to_i
end

@whole_system = File.readlines 'input'
@signals = { 'b' => 956 }
puts signal_for 'a'
