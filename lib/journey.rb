class Journey
  ERR_PROCESSING_COMPLETED_JOURNEY = 'Unable to alter journey as it has been marked as completed'.freeze
  ERR_EMPTY_JOURNEY = 'Journey has no stations attached'.freeze
  ERR_CHANGING_JOURNEY = 'Unable to change journey details if exit station if already set'.freeze

  MINIMUM_FARE = 6
  PENALTY_FARE = 9
  # nice

  attr_reader :entry_station, :exit_station, :complete

  def exit_station=(exit_station)
    raise ERR_CHANGING_JOURNEY unless @exit_station.nil?
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?

    @exit_station = exit_station
  end

  # allow change of entry station if a new journey is made without one and it needs to be updated
  # it isn't part of the user stories
  def entry_station=(entry_station)
    raise ERR_CHANGING_JOURNEY unless @exit_station.nil?

    @entry_station = entry_station
  end

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def complete?
    @complete
  end

  def process_fare
    raise ERR_PROCESSING_COMPLETED_JOURNEY if complete?
    raise ERR_EMPTY_JOURNEY if @entry_station.nil? && @exit_station.nil?

    @complete = true
    @fare = MINIMUM_FARE
    @fare = PENALTY_FARE if @entry_station.nil? || @exit_station.nil?
    @fare
  end
end
