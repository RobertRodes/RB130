require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
# require "minitest/reporters"
# Minitest::Reporters.use!

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

  def test_add
    test = Todo.new('Test')
    @list.add test
    assert_equal(test, @list.last)
  end

  def test_all_done
    @list.done!
    @list.mark_undone_at(1)
    assert_equal(@list.all_done.to_s, 
      <<~OUTPUT.chomp
      ---- Subset of Today's Todos ----
      [X] Buy milk
      [X] Go to gym
      OUTPUT
    )
  end

  def test_all_undone
    @list.done!
    @list.mark_undone_at(1)
    assert_equal(@list.all_undone.to_s,
      <<~OUTPUT.chomp
      ---- Subset of Today's Todos ----
      [ ] Clean room
      OUTPUT
    )    
  end

  def test_done!
    @list.done!
    assert_equal(false, @list.to_a.any? { |el| el.done == false })
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_each
    counter = 0
    @list.each do |el|
      assert_equal(@list.to_a[counter], el)
      counter += 1
    end
    assert_equal(@list, @list.each { |el| })
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_mark_all_done
    @list.mark_all_done
    assert_equal(@list.to_s, 
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [X] Clean room
      [X] Go to gym
      OUTPUT
    )
  end

  def test_mark_all_undone
    @list.mark_all_done
    @list.mark_all_undone
    assert_equal(@list.to_s, 
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
      OUTPUT
    )
  end

  def test_mark_done
    assert_raises(ArgumentError) { @list.mark_done('clean room') }
    @list.mark_done('Clean room')
    assert_equal(@list.to_s, 
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [X] Clean room
      [ ] Go to gym
      OUTPUT
    )
  end

  def test_mark_undone
    assert_raises(ArgumentError) { @list.mark_done('clean room') }
    @list.done!
    @list.mark_undone('Clean room')
    assert_equal(@list.to_s, 
      <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [ ] Clean room
      [X] Go to gym
      OUTPUT
    )
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

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(3) }
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal(@todo2, @list.to_a[0])
    assert_equal(2, @list.size)
  end

  def test_select
    result = @list.select { |el| el.title == 'Buy milk' }
    assert_equal(TodoList, result.class)
    assert_equal(1, result.size)
    assert_equal('Buy milk', result.item_at(0).title)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_shovel
    test = Todo.new('Test')
    @list << test
    assert_equal(test, @list.last)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_to_s
    assert_equal("---- #{@list.title} ----\n" + @list.todos.map(&:to_s).join("\n"),
      @list.to_s)
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

  def test_type_error
    assert_raises(TypeError) { @list.add(2939) }
    assert_raises(ArgumentError) { @list.add(Todo.new) }
    assert_raises(TypeError) { @list.add('Bob') }
    assert_raises(TypeError) { @list.add(TodoList.new('Buy milk')) }
  end
end