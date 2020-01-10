require 'minitest/autorun'
# require "minitest/reporters"
# Minitest::Reporters.use!

# require 'simplecov'
# SimpleCov.start

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    refute_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_type_error
    # assert(@list.add(2939) == TypeError)
    assert_raises(TypeError) { @list.add(Todo.new) }
    # assert_raises(TypeError) { @list.add('Bob') }
    # assert_raises(TypeError) { @list.add(TodoList.new('Buy milk')) }
  end

  def test_shovel
    test = Todo.new('Test')
    @list << test
    assert_equal(test, @list.last)
  end

  def test_add
    test = Todo.new('Test')
    @list.add test
    assert_equal(test, @list.last)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_raises(IndexError) { @list.mark_done_at(3) }
  end

  def test_mark_undone_at
    assert_equal(@list.to_a[0], @todo1)
    @todo1.done = true
    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
    assert_raises(IndexError) { @list.mark_undone_at(3) }
  end

  def test_done!
    @list.done!
    assert_equal(false, @list.to_a.any? { |el| el.done == false })
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(3) }
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal(@todo2, @list.to_a[0])
    assert_equal(2, @list.size)
  end

  def test_to_s
    assert_equal(@list.to_s,   
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
      OUTPUT
    )
    @list.mark_done_at(0)
    assert_equal(@list.to_s,   
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [ ] Clean room
      [ ] Go to gym
      OUTPUT
    )
    @list.done!
    assert_equal(@list.to_s,   
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [X] Clean room
      [X] Go to gym
      OUTPUT
    )
  end

  def test_each
    counter = 0
    @list.each do |el|
      assert_equal(@list.to_a[counter], el)
      counter += 1
    end
    assert_equal(@list, @list.each { |el| })
  end

  def test_select
    result = @list.select { |el| el.title == 'Buy milk' }
    assert_equal(TodoList, result.class)
    assert_equal(1, result.size)
    assert_equal('Buy milk', result.item_at(0).title)
  end
end