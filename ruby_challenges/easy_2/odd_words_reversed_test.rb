require 'minitest/autorun'
require_relative 'odd_words_reversed'
require 'stringio'

class OddWordsReversed < Minitest::Test
  def setup
    @io = StringIO.new
  end

  def capture_stdout
    stdout_store = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = stdout_store
  end

  def test_one_word
    test_input = 'good.'
    test_output = 'good.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_two_words
    test_input = 'good boys.'
    test_output = 'good syob.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_three_words
    test_input = 'good boys do.'
    test_output = 'good syob do.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_four_words
    test_input = 'good boys do fine.'
    test_output = 'good syob do enif.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_five_words
    test_input = 'good boys do fine always.'
    test_output = 'good syob do enif always.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_multiple_spaces_between_words
    test_input = 'good     boys   do  fine      always.'
    test_output = 'good syob do enif always.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)

  end

  def test_spaces_before_period
    test_input = 'good boys do fine always       .'
    test_output = 'good syob do enif always.'
    @io.puts odd_words_reversed(test_input)
    assert_equal(test_output, @io.string.chomp)
    assert_equal(test_output, 
      capture_stdout { odd_words_reversed_bonus(test_input)}.chomp)
  end

  def test_error_on_empty
    assert_raises(RuntimeError) { odd_words_reversed_bonus('') }
  end

  def test_error_on_no_period_at_end
    assert_raises(RuntimeError) { odd_words_reversed_bonus('good boys do fine always') }
  end

  def test_error_on_misplaced_period
    assert_raises(RuntimeError) { odd_words_reversed_bonus('good boys do fine. always.') }
  end

  def test_error_on_bad_characters
    assert_raises(RuntimeError) { odd_words_reversed_bonus('good boys do fine! always.') }
  end    
end