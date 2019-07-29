class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  ERR_BALANCE_LIMIT = 'Failed to change card as balance would pass the limit of #{MAXIMUM_BALANCE}.'.freeze
  ERR_TOUCH_IN_NO_FUNDS = 'Failed to start journey as there''s insufficient funds (less than #{MINIMUM_BALANCE}) on your card.'.freeze
  attr_reader :balance

  def initialize(balance = 0)
    raise ERR_BALANCE_LIMIT if balance > MAXIMUM_BALANCE

    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise ERR_BALANCE_LIMIT if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise ERR_TOUCH_IN_NO_FUNDS if balance < MINIMUM_BALANCE

    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
