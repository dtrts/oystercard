class Journey
  ERR_PROCESSING_COMPLETED_JOURNEY = 'Unable to alter journey as it has been marked as completed'.freeze
  ERR_EMPTY_JOURNEY = 'Journey has no stations attached'.freeze
  ERR_CHANGING_JOURNEY = 'Unable to change journey details if exit station if already set'.freeze

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  attr_reader :entry_station, :exit_station, :fare, :complete

  def exit_station=(exit_station)
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_CHANGING_JOURNEY unless @exit_station.nil?

    @exit_station = exit_station
  end

  # Returns the fare and sets as completed.
  def process_fare
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_EMPTY_JOURNEY if empty_journey?

    @complete = true
    @fare = incomplete_journey? ? PENALTY_FARE : full_journey_fare
  end

  private

  def full_journey_fare
    (entry_station.zone - exit_station.zone).abs + MINIMUM_FARE
  end

  def incomplete_journey?
    @entry_station.nil? || @exit_station.nil?
  end

  def empty_journey?
    @entry_station.nil? && @exit_station.nil?
  end

  def complete?
    @complete
  end
end
