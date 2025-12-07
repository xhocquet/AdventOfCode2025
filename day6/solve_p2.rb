
input = File.read('input.txt')
sample_input = File.read('sample_input.txt')
grid = input.lines.map { |line| line.gsub(/\n/, '').chars }

def print_grid(grid)
  grid.each do |row|
    puts "|#{row.join('|')}|"
  end
end

rotated_grid = grid.transpose.transpose.transpose
# print_grid(rotated_grid)
# print("\n")

blank_row_index = rotated_grid.find_index { |row| row.all? { |ch| ch =~ /\s/ } }
chunks = []

while blank_row_index
  chunk = rotated_grid.shift(blank_row_index)
  rotated_grid.shift # remove the blank row
  # puts "Blank row index: #{blank_row_index}"
  # print_grid(chunk)
  # print("\n")
  chunks << chunk
  blank_row_index = rotated_grid.find_index { |row| row.all? { |ch| ch =~ /\s/ } }
end
chunks << rotated_grid


total = 0

for chunk in chunks
  chunk_width = chunk[0].size
  chunk_operator = chunk[0][chunk_width-1]
  total += chunk.map{|x| x[..(chunk_width-1)].join.to_i}.reduce(chunk_operator)
end

puts "Total: #{total}"
