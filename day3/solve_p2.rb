sample_int = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

input = File.read('input.txt')

def highest_joltage(line)
  digits_needed = 12
  digits = []
  cur_chunk = line.chars.map(&:to_i)
  if cur_chunk.empty?
    return 0
  end

  # puts "Line: #{line}"

  while digits_needed > 0
    # puts "Cur chunk #{cur_chunk}"
    # puts "Digits needed #{digits_needed}"
    max_digit = cur_chunk[0..-digits_needed].max # exclude however many digits we still need
    # puts "Max digit: #{max_digit}"

    digits << max_digit
    digits_needed -= 1
    left_index = cur_chunk.index(max_digit)
    cur_chunk = cur_chunk[(left_index + 1)..]
  end

  # puts digits.join.to_i
  digits.join.to_i
end

sum = input.split("\n").sum do |line|
  highest_joltage(line)
end

puts "Sum: #{sum}"
