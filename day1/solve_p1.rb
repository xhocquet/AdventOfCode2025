input = File.read('input.txt')

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

  (start + modifier * steps) % 100
end

zeros = 0
current = 50
for line in sample_input.split("\n")
  current = rotate(current, line)
  if current == 0
    zeros += 1
  end
  puts "Step: #{line} - Current: #{current}"
end

puts "Zeros: #{zeros}"
