require 'minitest/autorun'

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(500)
    @trx = Transaction.new(50)
  end

  def test_accept_money
    @trx.amount_paid = 100
    prev_balance = @register.total_money
    @register.accept_money(@trx)
    assert_equal(@trx.amount_paid + prev_balance, @register.total_money)
  end

  def test_change
    @trx.amount_paid = 100
    assert_equal(50, @register.change(@trx))
  end

  def test_give_receipt
    output = capture_io {@register.give_receipt(@trx) }.first
    assert_equal("You've paid $50.\n", output)
  end

  def test_prompt_for_payment
    output = StringIO.new
    output_string = 
      'That is not the correct amount. Please make sure to pay the full cost.'
    @trx.prompt_for_payment(input: StringIO.new("40\n50"), output: output)
    assert_equal(output_string, output.string)
    assert_equal(50.0, @trx.amount_paid)
  end
end