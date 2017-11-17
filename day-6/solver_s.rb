require_relative '../utils/reader'
require 'byebug'

class SolverS

    def initialize
        instruction_set = Reader.get_instructions 'input'
        puts compute_lights_on(instruction_set)
    end

    def compute_lights_on(instruction_set)
        matrix = Array.new(1000) { Array.new(1000, false) }

        instruction_set.each do |instruction|
            parsed_instruction = parse_instruction(instruction)

            start_coords = parsed_instruction[:coordinates][0]
            end_coords = parsed_instruction[:coordinates][1]

            (start_coords[:x]..end_coords[:x]).each do |x|
                (start_coords[:y]..end_coords[:y]).each do |y|
                    case
                    when parsed_instruction[:action] == "turn on"
                        matrix[x][y] = true
                    when parsed_instruction[:action] == "turn off"
                        matrix[x][y] = false
                    when parsed_instruction[:action] == "toggle"
                        matrix[x][y] = !matrix[x][y]
                    end
                end
            end
        end
        count = matrix.inject(0) do |total, row|
            true_values = row.select { |item| item == true }
            total += true_values.length
        end            
        count
    end

    def parse_instruction(instruction)
        action = get_action(instruction)
        partial_instruction = instruction.gsub(action, "")
        
        {
            action: get_action(instruction),
            coordinates: get_coordinates(partial_instruction)
        }
    end

    def get_action(instruction)
        case true
        when instruction.include?("turn on")
            "turn on"
        when instruction.include?("turn off")
            "turn off"
        when instruction.include?("toggle")
            "toggle"
        else
            "No action"
        end
    end

    def get_coordinates(partial_instruction)
        start_coords, end_coords = partial_instruction.split(" through ")
        [
            {
                x: start_coords.split(",").first.to_i,
                y: start_coords.split(",").last.to_i
            },{
                x: end_coords.split(",").first.to_i,
                y: end_coords.split(",").last.to_i
            }
        ]
    end
end