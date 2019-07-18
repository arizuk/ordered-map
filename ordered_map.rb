class Node
  attr_accessor :prev, :nxt, :key, :value
  def initialize(prev: nil, nxt: nil, key:, value:)
    @prev = prev
    @nxt = nxt
    @key = key
    @value = value
  end
end

class OrderedMap
  def initialize
    @data = {}
    @head = nil
    @tail = nil
  end

  def insert(k, v)
    node = Node.new(key: k, value: v)

    if @tail
      @tail.nxt = node
      node.prev = @tail
    end

    @head ||= node
    @tail = node
    @data[k] = node

    true
  end

  def insert_after(k, k2, v)
    raise unless @data[k]
    remove(k2) if @data[k2]

    node = @data[k]
    nxt = node.nxt

    new_node = Node.new(key: k2, value: v)
    node.nxt = new_node
    new_node.prev = node
    new_node.nxt = nxt
    nxt.prev = new_node if nxt

    true
  end

  def get(k)
    @data[k].value
  end

  def remove(k)
    node = @data[k]
    @data.delete(k)

    prev = node.prev
    nxt = node.nxt

    prev.nxt = nxt if prev
    nxt.prev = prev if nxt

    @head = nxt if @head == node
    @tail = prev if @tail == node

    node.value
  end

  def each
    node = @head
    while node
      yield node.key, node.value
      node = node.nxt
    end
  end

  def inspect
    tmp = []
    each { |k,v| tmp << [k, v] }
    tmp
  end
end