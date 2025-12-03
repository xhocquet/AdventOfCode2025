sample_int = """987654321111111
811111111111119
234234234234278
818181911112111
"""

input = File.read('input.txt')

def highest_joltage(line)
  digits = line.chars.map(&:to_i)
  max_digit = digits[..-2].max
  # puts "Max digit: #{max_digit}"
  left_index = digits.index(max_digit)

  right_chunk = digits[left_index+1..]
  # puts "Right chunk: #{right_chunk}"
  max_digit_right = right_chunk.max
  # puts "Max digit right: #{max_digit_right}"

  # puts "Result: #{(max_digit.to_s + max_digit_right.to_s).to_i}"
  (max_digit.to_s + max_digit_right.to_s).to_i
end

sum = input.split("\n").sum do |line|
  # puts '--------------------------------'
  # puts "Line: #{line}"
  highest_joltage(line)
end

puts "Sum: #{sum}"
