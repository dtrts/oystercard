require_relative '../lib/oystercard.rb'
require_relative '../lib/station.rb'
require_relative '../lib/journey.rb'
require_relative '../lib/journey_log.rb'

card = Oystercard.new(90)
station = Station.new('Cannon Street', 1)
station2 = Station.new('Amersham', 9)

card.touch_in(station)
card.touch_out(station)
puts "balance should be 81 and equals  #{card.balance}"
