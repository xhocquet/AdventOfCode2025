class Node
  attr_accessor :id, :x, :y, :z

  def initialize(id, x, y, z)
    @id = id
    @x = x
    @y = y
    @z = z
  end
end

input = File.read('input.txt')
boxes = input.lines.map { |line| line.strip.split(',').map(&:to_i) }.map.with_index { |box, idx| Node.new(idx, *box) }

def distance(node1, node2)
  Math.sqrt(
    (node1.x - node2.x)**2 +
    (node1.y - node2.y)**2 +
    (node1.z - node2.z)**2
  )
end

def closest_pair(nodes)
  min_dist = Float::INFINITY
  pair = nil
  nodes.each_with_index do |a, i|
    ((i+1)...nodes.length).each do |j|
      b = nodes[j]
      d = distance(a, b)
      if d < min_dist
        min_dist = d
        pair = [a, b]
      end
    end
  end
  pair
end

def add_to_circuits(circuits, closest_pair)
  full_match = circuits.detect{|k, x| x.include?(closest_pair.first) && x.include?(closest_pair.last)}
  left_match = circuits.detect{|k, x| x.include?(closest_pair.first) && !x.include?(closest_pair.last)}
  right_match = circuits.detect{|k, x| !x.include?(closest_pair.first) && x.include?(closest_pair.last)}
  # puts "Adding closest pair: #{closest_pair.first.id} (#{closest_pair.first.x}, #{closest_pair.first.y}, #{closest_pair.first.z}), #{closest_pair.last.id} (#{closest_pair.last.x}, #{closest_pair.last.y}, #{closest_pair.last.z})"
  # puts "Matching pairs: Full: #{full_match}, Left: #{left_match}, Right: #{right_match}"
  if full_match
    # skip
  elsif left_match && right_match
    left_match[1].concat(right_match[1])
    circuits.delete(right_match[0])
  elsif left_match
    left_match[1] << closest_pair.last
  elsif right_match
    right_match[1] << closest_pair.first
  else
    new_key = circuits.keys.max.to_i + 1
    circuits[new_key] = [closest_pair.first, closest_pair.last]
  end
end

circuits = {}

# Prefetch all pairs sorted by distance
all_pairs = []
boxes.each_with_index do |a, i|
  ((i+1)...boxes.length).each do |j|
    b = boxes[j]
    all_pairs << [[a, b], distance(a, b)]
  end
end
sorted_pairs = all_pairs.sort_by { |_, dist| dist }.map(&:first)

last_x1 = nil
last_x2 = nil

sorted_pairs.each do |pair|
  # puts "Adding closest pair: #{pair.first.id} (#{pair.first.x}, #{pair.first.y}, #{pair.first.z}), #{pair.last.id} (#{pair.last.x}, #{pair.last.y}, #{pair.last.z})"
  last_x1 = pair.first.x
  last_x2 = pair.last.x
  add_to_circuits(circuits, pair)
  break if circuits.size == 1 && circuits.values.first.size == boxes.size
end

# puts "Circuits: #{circuits}"
# puts "Total number of circuits: #{circuits.size}"

# for k, v in circuits
#   puts "Circuit #{k}: #{v.map(&:id).join(', ')} (#{v.map{|x| "(#{x.x}, #{x.y}, #{x.z})"}.join(', ')})"
# end

final_circuit = circuits.values.first
puts "Final circuit size: #{final_circuit.size}"
puts "Results: #{last_x1 * last_x2}"
