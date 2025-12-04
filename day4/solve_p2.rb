sample_input = """..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

input = File.read('input.txt')

def print_grid(grid)
  grid.each do |row|
    puts row.join
  end
end

initial_grid = input.lines.map { |line| line.chomp.chars }
grid = initial_grid.dup

total_rolls = 0
height = grid.size
width = grid[0].size

# puts "Height: #{height}, Width: #{width}"
print_grid(grid)
print("\n")

def count_rolls(grid, height, width)
  rolls = 0
  roll_coordinates = []

  grid.each_with_index do |row, i|
    row.each_with_index do |col, j|
      next if grid[i][j] != '@'

      count = 0

      (-1..1).each do |di|
        (-1..1).each do |dj|
          next if di.zero? && dj.zero?

          ni = i + di
          nj = j + dj

          if ni >= 0 && ni < height && nj >= 0 && nj < width
            # puts "Looking at [#{ni},#{nj}]: #{grid[ni][nj]}"
            count += 1 if grid[ni][nj] == '@'
          end
        end
      end

      if count < 4
        rolls += 1
        roll_coordinates << [i, j]
      end
    end
  end

  [rolls, roll_coordinates]
end

def apply_dots(grid, coordinates)
  # Deep copy the grid (array of arrays)
  new_grid = grid.map(&:dup)
  coordinates.each do |i, j|
    new_grid[i][j] = '.'
  end
  new_grid
end


rolls, coordinates = count_rolls(grid, height, width)

while rolls > 0
  rolls, coordinates = count_rolls(grid, height, width)
  total_rolls += rolls
  grid = apply_dots(grid, coordinates)
  # puts "Rolls: #{rolls}, Total Rolls: #{total_rolls}"
  # print_grid(grid)
  # print("\n")
end

# print_grid(grid)
puts "Total Rolls: #{total_rolls}"
