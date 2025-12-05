sample_input = """3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

input = File.read('input.txt')
fresh_ingredient_ids, available_ingredients = input.split("\n\n")

# puts "Fresh ingredient IDs: #{fresh_ingredient_ids}"
# puts "Available ingredients: #{available_ingredients}"

available_ingredients = available_ingredients.split("\n").map(&:to_i)
fresh_ingredient_ranges = fresh_ingredient_ids.split("\n").map do |id|
  start, last = id.split("-")
  (start.to_i..last.to_i)
end

puts "Fresh ingredient ranges: #{fresh_ingredient_ranges}"
puts "Available ingredients: #{available_ingredients}"

result = available_ingredients.select do |ingredient|
  fresh_ingredient_ranges.any? do |range|
    range.include?(ingredient)
  end
end

puts "Result: #{result.size}"
