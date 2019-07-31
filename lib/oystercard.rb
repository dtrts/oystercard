class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 2
  ERR_BALANCE_LIMIT = 'Failed to change card as balance would pass the limit of #{MAXIMUM_BALANCE}.'.freeze
  ERR_TOUCH_IN_NO_FUNDS = 'Failed to start journey as there''s insufficient funds (less than #{MINIMUM_BALANCE}) on your card.'.freeze

  attr_reader :balance
  def journeys
    @journey_log.journeys
  end

  def initialize(balance = 0, journey_log_class = JourneyLog)
    raise ERR_BALANCE_LIMIT if balance > MAXIMUM_BALANCE

    @balance = balance
    @journey_log = journey_log_class.new
  end

  def top_up(amount)
    raise ERR_BALANCE_LIMIT if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    !!@journey_log.current_journey
  end

  def touch_in(entry_station)
    raise ERR_TOUCH_IN_NO_FUNDS if @balance < MINIMUM_BALANCE

    deduct(@journey_log.outstanding_charge)

    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(@journey_log.end(exit_station))
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def start_journey(entry_station)
    process_journey unless @journey.nil?

    @journey = Journey.new(entry_station)
  end

  def end_journey(exit_station)
    @journey = Journey.new(nil) if @journey.nil?
    @journey.exit_station = exit_station
    process_journey
  end

  def process_journey
    deduct(@journey.process_fare)
    @journeys << @journey
    @journey = nil
  end
end
