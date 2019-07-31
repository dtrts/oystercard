# Extract a journey class?

# Card will touch in to a station and pass that through to a journey
# Card will touch out of a station and spit out a journey and fare
# Card will deduct that amount.

# Wrote the code first don't be mad.

class Oystercard
  attr_reader :balance, :journey, :journeys

  def initialize(balance = 0)
    raise ERR_BALANCE_LIMIT if balance > MAXIMUM_BALANCE

    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise ERR_BALANCE_LIMIT if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    !!journey
  end

  def touch_in(entry_station)
    raise ERR_TOUCH_IN_NO_FUNDS if balance < MINIMUM_BALANCE

    start_journey(entry_station)
  end

  def touch_out(exit_station)
    end_journey(exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def start_journey(entry_station)
    process_journey unless @journey.nil?

    @journey = Journey.new(entry_station, nil)
  end

  def end_journey(exit_station)
    @journey = Journey.new(nil, exit_station) if @journey.nil?
    @journey.exit_station = exit_station
    process_journey
  end

  def process_journey
    @journey.process_fare
    deduct(@journey.fare)
    @journeys << @journey
    @journey = nil
  end
end

class Journey
  ERR_PROCESSING_COMPLETED_JOURNEY = 'Unable to process journey as it has been marked as completed'.freeze
  ERR_EMPTY_JOURNEY = 'Journey has no stations attached'.freeze
  ERR_CHANGING_JOURNEY = 'Unable to change exit station if already set'.freeze

  MINIMUM_FARE = 6
  PENALTY_FARE = 9
  # nice

  attr_reader :entry_station, :complete

  def exit_station=(exit_station)
    raise ERR_CHANGING_JOURNEY unless exit_station.nil?

    @exit_station = exist_station
  end

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @complete = false
  end

  def complete?
    @complete
  end

  def process_fare
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_EMPTY_JOURNEY if @entry_station.nil? && @exit_station.nil?

    @complete = true
    fare = MINIMUM_FARE
    fare += PENALTY_FARE if @entry_station.nil? || @exit_station.nil?
  end
end
