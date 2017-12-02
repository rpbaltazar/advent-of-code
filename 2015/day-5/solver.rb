def forbidden_strings?(string)
  forbidden = %w[ab cd pq xy]
  naughty = forbidden.find do |substring|
    string.include? substring
  end
  !naughty.nil?
end

def no_double_chars(string)
  prev_char = string.chars[0]
  double = string.chars[1..-1].find do |char|
    duplicate = char == prev_char
    prev_char = char
    duplicate
  end
  double.nil?
end

def no_three_vowels(string)
  string.count('aeiou') < 3
end

def naughty_one?(string)
  return true if forbidden_strings?(string)
  return true if no_double_chars(string)
  return true if no_three_vowels(string)
  false
end

def spaced_repeat?(string)
  char_ary = string.chars
  char_ary.each_with_index do |char, idx|
    break unless char_ary[idx + 2]
    return true if char == char_ary[idx + 2]
  end
  false
end

def two_letters?(string)
  char_ary = string.chars
  char_ary.each_with_index do |_, idx|
    pair = char_ary[idx..idx + 1]
    break if pair.length != 2
    sub_ary = char_ary[idx + 2..-1]
    sub_ary.each_with_index do |_char, internal_idx|
      new_pair = sub_ary[internal_idx..internal_idx + 1]
      break if new_pair.length != 2
      return true if pair == new_pair
    end
  end
  false
end

def naughty_two?(string)
  return true unless spaced_repeat?(string)
  return true unless two_letters?(string)
  false
end

def init(part)
  nice_string_count = 0

  File.open('input').each do |string|
    naughty_string = if part == 1
                       naughty_one?(string)
                     else
                       naughty_two?(string)
                     end
    next if naughty_string
    nice_string_count += 1
  end

  nice_string_count
end

def part1
  init(1)
end

def part2
  init(2)
end

puts part1
puts part2
