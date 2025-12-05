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

# available_ingredients = available_ingredients.split("\n").map(&:to_i)
fresh_ingredient_ranges = fresh_ingredient_ids.split("\n").map do |id|
  start, last = id.split("-")
  (start.to_i..last.to_i)
end

puts "Fresh ingredient ranges: #{fresh_ingredient_ranges}"

start_stops = fresh_ingredient_ranges.flat_map do |range|
  [
    {type: :start, val: range.min},
    {type: :end, val: range.max},
  ]
end
start_stops.sort_by!{|x| [x[:val], x[:type] == :start ? 0 : 1]}

depth = 0
merged_ranges = []
start_stops.each do |ss|
  if ss[:type] == :start
    if depth == 0
      merged_ranges << ss
    end
    depth += 1
  else
    depth -= 1
    if depth == 0
      merged_ranges << ss
    end
  end
end

start_stops = merged_ranges

puts start_stops
item_count = 0

start_stops.each.with_index do |ss, i|
  if ss[:type] == :end && start_stops[i-1][:type] == :start
    item_count += (start_stops[i-1][:val]..ss[:val]).size
  end
end

puts "Item count: #{item_count}"
