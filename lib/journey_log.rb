class JourneyLog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  NO_CHARGE = 0

  attr_accessor :current_journey

  def start(entry_station)
    raise ERR_JOURNEY_IN_PROGRESS unless @current_journey.nil?

    @current_journey = @journey_class.new(entry_station)
  end

  def end(exit_station)
    # if no current journey have to make one and return a penalty fare
    @current_journey = @journey_class.new(nil) if @current_journey.nil?
    @current_journey.exit_station = exit_station
    @fare = @current_journey.process_fare
    @journeys << @current_journey
    @current_journey = nil
    @fare
  end

  def outstanding_charge
    # Finish off current journey, mark as complete. Otherwise return zilch.
    if @current_journey
      @fare = @current_journey.process_fare
      @journeys << @current_journey
      @current_journey = nil
      @fare
    else
      NO_CHARGE
    end
  end

  def journeys
    @journeys.dup
  end
end
