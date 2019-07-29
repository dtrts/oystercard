class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 2
  ERR_BALANCE_LIMIT = 'Failed to change card as balance would pass the limit of #{MAXIMUM_BALANCE}.'.freeze
  ERR_TOUCH_IN_NO_FUNDS = 'Failed to start journey as there''s insufficient funds (less than #{MINIMUM_BALANCE}) on your card.'.freeze
  attr_reader :balance, :entry_station

  def initialize(balance = 0)
    raise ERR_BALANCE_LIMIT if balance > MAXIMUM_BALANCE

    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise ERR_BALANCE_LIMIT if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(entry_station)
    raise ERR_TOUCH_IN_NO_FUNDS if balance < MINIMUM_BALANCE

    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    @entry_station = nil
    deduct(FARE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
