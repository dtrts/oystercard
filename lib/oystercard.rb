class Oystercard
  MAXIMUM_BALANCE = 90

  ERR_BALANCE_LIMIT = 'Failed to change card as balance would pass the limit of #{MAXIMUM_BALANCE}.'.freeze

  attr_reader :balance

  def initialize(balance = 0)
    raise ERR_BALANCE_LIMIT if balance > MAXIMUM_BALANCE

    @balance = balance
  end

  def top_up(amount)
    raise ERR_BALANCE_LIMIT if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
    amount
  end

  def deduct(amount)
    @balance -= amount
    amount
  end
end
