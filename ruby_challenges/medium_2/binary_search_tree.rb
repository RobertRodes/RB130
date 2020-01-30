# Binary search tree
class Bst
  include Enumerable

  attr_accessor :left, :right
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def each(node = self, &block)
    return self.to_enum unless block_given?
    each_execute(node.sort, &block)
    self
  end

  def insert(data)
    node = find_node(data)
    data > node.data ? node.right = Bst.new(data) : node.left = Bst.new(data)
  end

  # Note: does not sort in place -- see #extract_nodes
  def sort
    sorted_nodes = extract_nodes(self).sort_by(&:data)
    sorted_tree = sorted_nodes[0]
    sorted_nodes.each_cons(2) do |node1, node2|
      node1.data == node2.data ? node1.left = node2 : node1.right = node2
    end
    sorted_tree
  end

  private

  def each_execute(node, &block)
    yield node.data
    return if node.left.nil? && node.right.nil?
    each_execute(node.left, &block) unless node.left.nil?
    each_execute(node.right, &block) unless node.right.nil?
  end

  def extract_nodes(node, nodes = [])
    nodes << Bst.new(node.data)
    extract_nodes(node.left, nodes) unless node.left.nil?
    extract_nodes(node.right, nodes) unless node.right.nil?
    nodes
  end

  def find_node(data, node = self)
    return node if
      data > node.data && node.right.nil? ||
      data <= node.data && node.left.nil?
    node = data > node.data ? node.right : node.left
    find_node(data, node)
  end
end

# tree = Bst.new(4)
# tree.insert(2)
# tree.insert(5)
# tree.insert(3)
# tree.insert(8)
# tree.insert(2)
# tree.insert(6)
# pp tree.extract_nodes(tree).sort_by { |node| node.data }
# pp tree
# pp tree
# p record_all_data(tree)
# p tree.each
# p tree.record_all_data(tree)
