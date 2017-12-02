require 'byebug'

def compute_distance(path)
  distance = 0
  last_idx = path.length - 1
  path.each_with_index do |city, idx|
    next if idx == last_idx
    from = city
    to = path[idx + 1]
    distance += @roadmap[from][to]
  end
  distance
end

@roadmap = {}
File.readlines('input').each do |line|
  parts = line.split ' '
  @roadmap[parts[0]] ||= {}
  @roadmap[parts[0]][parts[2]] = parts[4].to_i
  @roadmap[parts[2]] ||= {}
  @roadmap[parts[2]][parts[0]] = parts[4].to_i
end

min_path_length = (2**(0.size * 8 - 2) - 1)
max_path_length = 0
possible_paths = @roadmap.keys.permutation.to_a
possible_paths.each do |path|
  distance = compute_distance path
  min_path_length = distance if distance < min_path_length
  max_path_length = distance if distance > max_path_length
end

puts min_path_length
puts max_path_length
