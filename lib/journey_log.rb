class JourneyLog
  ERR_JOURNEY_IN_PROGRESS = 'Attempting to start a new journey without completing outstanding fares'.freeze

  NO_CHARGE = 0

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def current_journey
    @current_journey.dup
  end

  def journeys
    @journeys.dup
  end

  def start(entry_station)
    raise ERR_JOURNEY_IN_PROGRESS unless @current_journey.nil?

    reveal_journey(entry_station)
    # @current_journey = @journey_class.new(entry_station)
  end

  def end(exit_station)
    # if no current journey have to make one and return a penalty fare
    reveal_journey.exit_station = exit_station

    process_journey
  end

  def outstanding_charge
    if @current_journey
      process_journey
    else
      NO_CHARGE
    end
  end

  private

  def reveal_journey(entry_station = nil)
    @current_journey ||= @journey_class.new(entry_station)
  end

  def process_journey
    @fare = @current_journey.process_fare
    @journeys << @current_journey
    @current_journey = nil

    @fare
  end
end
