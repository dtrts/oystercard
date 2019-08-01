class Journey
  ERR_PROCESSING_COMPLETED_JOURNEY = 'Unable to alter journey as it has been marked as completed'.freeze
  ERR_EMPTY_JOURNEY = 'Journey has no stations attached'.freeze
  ERR_CHANGING_JOURNEY = 'Unable to change journey details if exit station if already set'.freeze

  MINIMUM_FARE = 6
  PENALTY_FARE = 9
  # nice
  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  attr_reader :entry_station, :exit_station, :complete, :fare

  def complete?
    @complete
  end

  def exit_station=(exit_station)
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_CHANGING_JOURNEY unless @exit_station.nil?

    @exit_station = exit_station
  end

  # Returns the fare and sets as completed.
  def process_fare
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_EMPTY_JOURNEY if @entry_station.nil? && @exit_station.nil?

    @complete = true
    @fare = @entry_station.nil? || @exit_station.nil? ? PENALTY_FARE : MINIMUM_FARE
  end
end
