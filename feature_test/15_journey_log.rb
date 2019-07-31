require_relative "../lib/Oystercard.rb"
require_relative "../lib/JourneyLog.rb"
require_relative "../lib/Journey.rb"
require_relative "../lib/Station.rb"

st0 = Station.new("asd" ,1)
st1 = Station.new("qwe" ,2)
card0 = Oystercard.new(90)


card0.touch_in(st0)
card0.touch_out(st1)

# Card will have journeys accessor

Journey log will have to be able to tell card weather or not to deduct money.




Journey log needs to make new journeys.
Dependency injection????


DIPPIDIDO

def new_journey(entry_station, journey = Journey)
  journey.new.(entry_station )
end
journy is the default class but can be changed if we need touch_in



# need to check the log for anyout standing journeys before starting a new one.
# JourneyLog.outstanding_charge -- return wswwsjdw
# check journey list for unfinished journeys
# journeys will be a dependency injection so the log can have no journey journeys.

# Oystercard.journeys now takes from the log so don't need to test it as much.
# Same with touch in and touch out. ish. Just need to make sure that the journey works?

journey_log = JourneyLog.new(Journey)

journey_log.start(entry_station)
journey_log.finish(exit_station)
journey_log.current_journey
journey_log.journeys # will return all the journeys (but not allow them to be  ) .dup
journey_log.outstanding_charge # will finish off current_journey and return the fare to deduct.


JourneyLog.start_journey(entry_station)

