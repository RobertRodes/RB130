class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # def <<(list_item)
  #   add(list_item)
  # end

  def add(list_item)
    raise TypeError, 'Can only add Todo objects' unless list_item.class == Todo 
    @todos << list_item
  end
  alias_method :<<, :add

  def all_done
    select(&:done?)
  end

  def all_undone
    select { |el| !el.done? }
  end

  def done!
    @todos.each(&:done!)
  end

  def done?
    @todos.all?(&:done?)
  end

  def each
    counter = 0
    while counter < @todos.size
      yield @todos[counter]
      counter += 1
    end
    self
  end

  def find_by_title(todo_title)
    # @todos.each { |el| return el if el.title == todo_title }
    # nil
    select { |el| el.title == todo_title }.first
  end

  def first
    @todos.first
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def last
    @todos.last
  end

  def mark_all_done
    puts block_given?
    each(&:done!)
  end

  def mark_all_undone
    each(&:undone!)
  end

  def mark_done(item_title)
    todo = find_by_title(item_title)
    raise ArgumentError, "Todo item '#{item_title}' not found" if todo.nil?
    todo.done!
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def select
    new_list = TodoList.new("Subset of #{@title}")
    items = @todos.select { |el| yield el }
    items.each { |el| new_list.add(el) }
    new_list
  end

  def shift
    @todos.shift
  end

  def size
    @todos.size
  end

  def to_a
    @todos
  end

  def to_s
    "---- #{@title} ----\n" + @todos.map(&:to_s).join("\n")
  end

  # rest of class needs implementation

end

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list << todo3                   # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----



# # size
# puts list.size                       # returns 3

# # first
# puts list.first                      # returns todo1, which is the first item in the list

# # last
# puts list.last                       # returns todo3, which is the last item in the list

# #to_a
# puts list.to_a                      # returns an array of all items in the list

# #done?
# puts list.done?                     # returns true if all todos in the list are done, otherwise false                         

# # ---- Retrieving an item in the list ----

# # item_at
# # puts list.item_at                    # raises ArgumentError
# puts list.item_at(1)                 # returns 2nd item in list (zero based index)
# # puts list.item_at(100)               # raises IndexError

# # ---- Marking items in the list -----

# # mark_done_at
# # list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
# # list.mark_done_at(100)          # raises IndexError
# # puts list.to_a

# # mark_undone_at
# # list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done,
# # list.mark_undone_at(100)        # raises IndexError
# puts list.to_a

# # done!
# list.done!                      # marks all items as done
# puts list.to_a

# # ---- Deleting from the list -----

# # shift
# puts list.shift                      # removes and returns the first item in list

# # pop
# puts list.pop                        # removes and returns the last item in list

# # remove_at
# # list.remove_at                  # raises ArgumentError
# puts list.remove_at(1)               # removes and returns the 2nd item
# # list.remove_at(100)             # raises IndexError
# puts
# puts list.to_a

# ---- Outputting the list -----

# to_s
# puts list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym

# # each
# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# # select
# list.mark_done_at(2)
# puts list.select { |todo| todo.done? }    # you need to implement this method

# # find_by_title
# puts list.find_by_title('Clean room')
# p list.find_by_title('Bob')

# # all_done
# list.mark_done_at(1)
# list.mark_done_at(2)
# puts list.all_done

# # all_not_done
# list.mark_undone_at(1)
# puts list.all_undone

# # mark_done
# # list.mark_done('clean room') # should respond "Todo item 'clean room' not found (ArgumentError)"
# list.mark_done('Clean room')
# puts list

# mark_all_done
list.mark_all_done
puts list

# mark_all_undone
list.mark_all_undone
puts list
