input = File.read('input.txt')

sample_input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124"


def valid?(id)
  return false if id.chars.first.to_i.zero?

  if id.chars.size % 2 > 0
    return true
  end

  half = id.chars.size / 2
  return id[0...half] != id[half..-1]
end


ranges = input.split(',')
invalid_ids = []
ranges.each do |range|
  start, last = range.split('-')
  x =  (start.to_i..last.to_i).select { |id| !valid?(id.to_s) }
  # puts "Invalid IDs: #{x}"
  invalid_ids << x
end

puts "Invalid IDs: #{invalid_ids.flatten.compact.sum}"
