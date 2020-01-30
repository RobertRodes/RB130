# # Element
# class Element
#   attr_reader :datum

#   def initialize(datum = nil, the_next = nil)
#     @datum = datum
#     @next = the_next.object_id
#   end

#   def next
#     els = ObjectSpace.each_object(Element).to_a
#     els.find { |el| el.object_id == @next }
#   end

#   def next=(el_id)
#     @next = el_id
#   end

#   def tail?
#     @next == nil.object_id
#   end
# end

# # SimpleLinkedList
# class SimpleLinkedList < Array
#   def <<(el)
#     push(el)
#   end

#   def self.from_a(data)
#     data&.reverse&.each_with_object(new) { |d, list| list.push(d) } || new
#   end

#   def head
#     (self - map(&:next)).first
#   end

#   def peek
#     head&.datum
#   end

#   def push(datum)
#     concat([Element.new(datum, last)])
#   end

#   def pop
#     delete_at(-1).datum
#   end

#   def reverse
#     SimpleLinkedList.from_a(to_a.reverse)
#   end

#   def to_a
#     map(&:datum).reverse
#   end
# end

class Element
  attr_reader :datum, :next

  def initialize(datum, next_node=nil)
    @datum = datum
    @next = next_node
  end

  def tail?
    @next.nil?
  end

  def <=>(other_node)
    datum <=> other_node.datum
  end
end

class SimpleLinkedList
  include Enumerable

  attr_reader :head

  def self.from_a(arr)
    arr = [] if arr.nil?
    arr = arr.dup

    list = new
    list.push(arr.pop) until arr.empty?
    list
  end

  def empty?
    head.nil?
  end

  def each
    return to_enum unless block_given?

    current_node = head
    while current_node
      yield(current_node)
      current_node = current_node.next
    end

    self
  end

  def size
    list_size = 0
    each { list_size += 1 }
    list_size
  end

  def push(datum)
    @head = Element.new(datum, @head)
  end

  def pop
    old_head = @head.datum
    @head = @head.next
    old_head
  end

  def peek
    @head&.datum
  end

  def reverse
    list = SimpleLinkedList.new
    each { |node| list.push(node.datum) }
    list
  end

  def to_a
    arr = []
    each { |current_node| arr << current_node.datum }
    arr
  end
end
