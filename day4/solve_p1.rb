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

grid = input.lines.map { |line| line.chomp.chars }

rolls = 0
height = grid.size
width = grid[0].size

puts "Height: #{height}, Width: #{width}"

print_grid(grid)


grid.each_with_index do |row, i|
  row.each_with_index do |col, j|
    # Count number of '@' in the surrounding 8 cells
    count = 0
    # puts "3x3 grid centered on (#{i},#{j}):"
    # (-1..1).each do |di|
    #   row_str = ""
    #   (-1..1).each do |dj|
    #     ni = i + di
    #     nj = j + dj
    #     if ni >= 0 && ni < height && nj >= 0 && nj < width
    #       row_str << grid[ni][nj]
    #     else
    #       # row_str << "."
    #     end
    #   end
    #   puts row_str
    # end
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

    # puts "Count: #{count}, #{"Can move" if count < 4}"
    # puts "-------------------------------"
    rolls += 1 if count < 4 && grid[i][j] == '@'
  end
end

puts "Rolls: #{rolls}"
