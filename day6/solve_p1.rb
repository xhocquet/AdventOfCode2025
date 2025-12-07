sample_input = """123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +
"""

input = File.read('input.txt')
grid = input.gsub(/[ \t]+/, ' ').lines.map { |line| line.strip.split(' ') }.transpose

results = grid.map do |row|
  operation = row.pop
  row.map(&:to_i).reduce(operation)
end

print(results.sum)
print("\n")
