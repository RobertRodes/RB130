class CircularBuffer
  class BufferFullException < StandardError
    def initialize(msg = 'buffer full')
      super
    end
  end

  class BufferEmptyException < StandardError
    def initialize(msg = 'buffer empty')
      super
    end
  end

  attr_reader :buffer

  def initialize(bsize)
    @bsize = bsize
    clear
  end

  def clear
    @buffer = Array.new(@bsize)
    @start_index = 0
    @end_index = 0
  end

  def read
    raise BufferEmptyException if buffer_empty?
    char = @buffer[@start_index]
    @buffer[@start_index] = nil
    @start_index = next_index(@start_index)
    char
  end

  def write(char)
    # binding.pry
    raise BufferFullException if buffer_full?
    write!(char)
  end

  def write!(char)
    return if char.nil?
    if buffer_full?
      write_index = @start_index
      @start_index = next_index(@start_index)
    else
      write_index = @end_index
      @end_index = next_index(@end_index)
    end
    @buffer[write_index] = char
  end

  private

  def buffer_empty?
    @buffer.compact.empty?
  end

  def buffer_full?
    @buffer.compact.size == @bsize
  end

  def next_index(value)
    (value + 1) % @bsize
  end
end
