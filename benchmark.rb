require 'benchmark'
require './ordered_map'

TIMES = 1000
MAX = 20000

def liner_get(pairs)
  TIMES.times do |k|
    pairs.find { |p| p[0] == k }
  end
end

def liner_delete(pairs)
  TIMES.times do |k|
    idx = pairs.find_index { |p| p[0] == k }
    pairs.delete_at(idx)
  end
end


def ordered_map_get(map)
  TIMES.times do |k|
    map.get(k)
  end
end

def ordered_map_delete(map)
  TIMES.times do |k|
    map.remove(k)
  end
end

def ordered_map_insert_before(map)
  TIMES.times do |k|
    map.insert_after(k, MAX+k, MAX+k)
  end
end

pairs = (0...MAX).map { |k| [k, k] }
pairs = pairs.shuffle
pairs2 = pairs.dup

map = OrderedMap.new
map2 = OrderedMap.new
map3 = OrderedMap.new

pairs.each do |k, v|
  map.insert(k, v)
  map2.insert(k, v)
  map3.insert(k, v)
end

Benchmark.bm 30 do |r|
  r.report 'liner_get' do
    liner_get(pairs)
  end

  r.report 'liner_delete' do
    liner_delete(pairs2)
  end

  r.report 'ordered_map_get' do
    ordered_map_get(map)
  end

  r.report 'ordered_map_delete' do
    ordered_map_delete(map2)
  end

  r.report 'ordered_map_insert_before' do
    ordered_map_insert_before(map3)
  end
end