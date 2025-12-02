input = File.read('input.txt')

# sample_input = """
# L1000
# """
sample_input = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

def rotate(start, input)
  direction = input[0]
  steps = input[1..].to_i
  modifier = direction == 'L' ? -1 : 1

  steps_to_zero = modifier == -1 ? (start == 0 ? 100 : start) : 100 - start
  new_value = (start + modifier * steps) % 100

  zs = 0
  while steps >= steps_to_zero
    zs += 1
    steps -= 100
  end

  zs = [zs, 0].max

  [new_value, zs]
end

zeros = 0
current = 50

for line in input.split("\n")
  new_value, zs = rotate(current, line)
  zeros += zs
  puts "#{current}: #{line} - New Value: #{new_value} - Zeros: #{zs}"
  current = new_value
end

puts "Zeros: #{zeros}"
