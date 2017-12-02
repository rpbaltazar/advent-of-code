whole_file = File.readlines('input')
total_length = 0
actual_chars = 0
esc_chars = 0
whole_file.each do |line|
  line = line.chomp
  total_length += line.length
  esc_chars += line.dump.length
  actual_chars += eval(line).length
end

puts total_length - actual_chars
puts esc_chars - total_length
